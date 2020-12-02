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
    func updateResults(repoList: [RepositoryItemViewModel], pagination: Pagination)
    func resultsFound(didFound:Bool)
}

class MainViewController: UIViewController, UISearchBarDelegate {
    // Reference to presenter
    private var presenter: MainPresentation
    // MARK: Views initialization
    private var tableView: UITableView = { return UITableView() }()
    private var noResultsView: UIView = { return UIView() }()
    private var noResultsLbl: UILabel = { return UILabel() }()
    private let navItem = UINavigationItem(title: "Home")
    let searchController = UISearchController(searchResultsController: nil)
    private let apiOptions: [String] = ["Repos named ",
                                          "Repo owner is ",
                                          "Description contains ",
                                          "Read Me contains "]
    // MARK: Functional Vars and constants
    private static let repositoryCellID = "repoItemCell"
    private static let optionsCellID = "optionsCell"
    var queryOptions: [String] = []
    var pagination: Pagination?
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    // TODO: Pass is filtering to presenter
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
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
    /// Receives results from presenter
    ///
    /// - Parameters:
    ///     - repoList: array containing repo object to be displayed
    ///     - pagination: Pagination object if query has more than 30 results
    func updateResults(repoList: [RepositoryItemViewModel], pagination: Pagination) {
        //The fatched data is received here
            self.pagination = pagination
            if self.datasource.isEmpty {
                self.datasource = repoList
            } else {
                self.datasource.append(contentsOf: repoList)
                self.tableView.reloadData()
            }
    }
    func resultsFound(didFound: Bool) {
        tableView.isHidden = !didFound
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        tableView.isHidden = false
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }

    func filterContentForSearchText(_ searchText: String) {
        queryOptions = []
        for option in apiOptions {
            queryOptions.append(option + searchText)
        }
        tableView.reloadData()
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
    func get_option_cell(indexPath: IndexPath)  -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as! OptionsCell
        // swiftlint:enable force_cast
        var searchOption = ""
        if isFiltering {
            searchOption = self.queryOptions[indexPath.row]
        } else {
            searchOption = self.apiOptions[indexPath.row]
        }
        cell.configure(withOptions: searchOption)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            let searchBar = searchController.searchBar
            let keywords = searchBar.text!.components(separatedBy: " ")
            self.searchController.isActive = false
            self.datasource = []
            switch indexPath.row {
            case 0:
                //presenter -> router search reponame
                presenter.searchRepos(for: keywords, with: ["in": "name"])
            case 1:
                presenter.searchRepos(for: keywords, with: ["user": "username"])
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let nextPage = pagination?.next, nextPage.isEmpty == false else {
            return
        }
        if isFiltering == false {
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                // print("this is the last cell")
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.color = UIColor.tracerGreen
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                self.tableView.tableFooterView = spinner
                self.tableView.tableFooterView?.isHidden = false
                self.presenter.loadNextPage(link: nextPage)
            }
        }
    }
}
