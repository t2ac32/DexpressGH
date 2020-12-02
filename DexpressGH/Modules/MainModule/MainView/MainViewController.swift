//
//  MainViewController.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit
import Foundation

protocol MainViewInterface: class {
    func reloadData(isFiltering: Bool)
    func resultsFound(didFound: Bool)
    func showTableLoader()
    func hideTableLoader()
    func dismissSearch()
    func setDataSource(repoList: [RepositoryItemViewModel])
    func updateDataSource(repoList: [RepositoryItemViewModel])
    func updatePagination(pagination: Pagination)
    func updateQueryOptions(options: [String])
}

class MainViewController: UIViewController, UISearchBarDelegate {
    // Reference to presenter
    private var presenter: MainPresentation
    // MARK: Views initialization
    private var tableView: UITableView = UITableView()
    private var noResultsView: UIView = UIView()
    private var noResultsLbl: UILabel = UILabel()
    private let navItem = UINavigationItem(title: "Home")
    private let spinner = UIActivityIndicatorView(style: .gray)
    let searchController = UISearchController(searchResultsController: nil)
    // MARK: Functional Vars and constants
    private static let repositoryCellID = "repoItemCell"
    private static let optionsCellID = "optionsCell"
    private var queryOptions: [String] = []
    var pagination: Pagination?
    var isFiltering: Bool = false
    
    // TODO: Pass is filtering to presenter
    var datasource: [RepositoryItemViewModel] = [] {
        didSet { self.tableView.reloadData() }
    }
    init(presenter: MainPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view.
        setupNoResultsView()
        setupTableView()
        setupSearchController()
        setupView()
        configTableView()
        presenter.viewDidLoad()
    }
    // MARK: Subviews setups
    func setupView() {
        view.backgroundColor = .black
        guard let nbar = self.navigationController?.navigationBar else {
            return
        }
        nbar.isTranslucent = false
        nbar.barTintColor = .black
        nbar.titleTextAttributes = [.foregroundColor: UIColor.tracerGreen]
        self.title = "Home"
    }
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search GitHub Repos"
        searchController.searchBar.barStyle = .black
        navigationItem.searchController = searchController
        definesPresentationContext = false
        tableView.register(UINib(nibName: "OptionsCell", bundle: nil), forCellReuseIdentifier: MainViewController.optionsCellID)
    }
    func setupTableView() {
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(UINib(nibName: "RepoItemCell", bundle: nil), forCellReuseIdentifier: MainViewController.repositoryCellID)
        view.addSubview(tableView)
    }
    func configTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    func setupNoResultsView() {
        view.addSubview(noResultsView)
        noResultsView.translatesAutoresizingMaskIntoConstraints = false
        noResultsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        noResultsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        noResultsView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        noResultsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        noResultsView.backgroundColor = .black
        noResultsView.addSubview(noResultsLbl)
        noResultsLbl.translatesAutoresizingMaskIntoConstraints = false
        noResultsLbl.centerYAnchor.constraint(equalTo: noResultsView.centerYAnchor).isActive = true
        noResultsLbl.leftAnchor.constraint(equalTo: noResultsView.leftAnchor, constant: 0).isActive = true
        noResultsLbl.rightAnchor.constraint(equalTo: noResultsView.rightAnchor, constant: 0).isActive = true
        noResultsLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
        noResultsLbl.textColor = UIColor.tracerGreen
        noResultsLbl.backgroundColor = .none
        noResultsLbl.font.withSize(35)
        noResultsLbl.text = "No results Found"
        noResultsLbl.textAlignment = .center
    }
}

// MARK: View Protocol
extension MainViewController: MainViewInterface {
    /// Updates Serachbar query options acoording to keywords
    func updateQueryOptions(options: [String]) {
        queryOptions = options
    }
    func reloadData(isFiltering: Bool) {
        self.isFiltering = isFiltering
        self.tableView.reloadData()
    }
    func dismissSearch() {
        self.searchController.isActive = false
    }
    func setDataSource(repoList: [RepositoryItemViewModel]) {
        self.datasource = repoList
    }
    func updateDataSource(repoList: [RepositoryItemViewModel]) {
        self.datasource.append(contentsOf: repoList)
    }
    func updatePagination(pagination: Pagination) {
        self.pagination = pagination
    }
    func resultsFound(didFound: Bool) {
        tableView.isHidden = !didFound
    }
    func showTableLoader() {
        spinner.color = UIColor.tracerGreen
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        self.tableView.tableFooterView = spinner
        self.tableView.tableFooterView?.isHidden = false
    }
    func hideTableLoader() {
        spinner.stopAnimating()
        self.tableView.tableFooterView?.isHidden = true
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.presenter.updateQueryOptions(searchText: searchBar.text!)
    }
}

// MARK: TableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.queryOptions.count
        }
        return self.datasource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFiltering {
            return get_option_cell(indexPath: indexPath)
        }
        let repoItem = self.datasource[indexPath.row]
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewController.repositoryCellID, for: indexPath) as! RepoItemCell
        // swiftlint:enable force_cast
        cell.configure(usingModel: repoItem)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isFiltering { return 44 }
        return 101
    }
    func get_option_cell(indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as! OptionsCell
        // swiftlint:enable force_cast
        var searchOption = ""
        if isFiltering {
            searchOption = queryOptions[indexPath.row]
        }
        cell.configure(withOptions: searchOption)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            let searchBar = searchController.searchBar
            self.presenter.isSearching(active: false, hasText: searchBar.text?.isEmpty ?? true)
            let keywords = searchBar.text!.components(separatedBy: " ")
            self.datasource = []
            switch indexPath.row {
            case 0:
                //presenter -> router search reponame
                presenter.searchRepos(for: keywords, with: ["in": "name"])
            case 1:
                presenter.searchRepos(for: [], with: ["user": searchBar.text!])
            case 2:
                presenter.searchRepos(for: keywords, with: ["in": "description"])
            case 3:
                presenter.searchRepos(for: keywords, with: ["in": "readme"])
            default:
                print("search query not found")
            }
        }
    }
}

// MARK: TABLE VIEW DELEGATE
extension MainViewController: UITableViewDelegate {
}

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let nextPage = pagination?.next, nextPage.isEmpty == false else {
            return
        }
        if isFiltering == false {
            let needsFetch = indexPaths.contains { $0.row == self.datasource.count - 2 }
            if needsFetch { // show request next page and show spinner
                self.presenter.requestNextPage(link: nextPage)
            }
        }
    }
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    }
}
