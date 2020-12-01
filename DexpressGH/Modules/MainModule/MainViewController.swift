//
//  MainViewController.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit
import Foundation

protocol MainView: class{
    func updateResults(repoList: [RepositoryItemViewModel], pagination: [String:String]) -> ()
}

class MainViewController: UIViewController, UISearchBarDelegate {
    
    // Reference to presenter
    private var presenter: MainPresentation
    private var tableView: UITableView = { return UITableView() }()
    
    private let navItem = UINavigationItem(title: "Home")
    let searchController = UISearchController(searchResultsController: nil)
    private let api_options:[String] = ["Repos named ",
                                          "Repo owner is ",
                                          "Description contains ",
                                          "ReadME contains "]
    var query_options: [String] = []
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    
    private static let repositoryCellID = "repoItemCell"
    private static let optionsCellID = "optionsCell"
    
    var pagination: [String:String] = [:]
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
        setupTableView()
        setupSearchController()
        setupView()
        configTableView()
        // Do additional setup after loading the view.
        presenter.viewDidLoad()
        
    }
    
    func setupView(){
        view.backgroundColor = .black
        guard let nbar = self.navigationController?.navigationBar else {
            return
        }
        nbar.barTintColor = .black
        nbar.titleTextAttributes = [.foregroundColor: UIColor.tracer_Green]
        self.title = "Home"
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search GitHub"
        searchController.searchBar.barStyle = .black
        navigationItem.searchController = searchController
        definesPresentationContext = true
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor
            , constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.query_options.count
        }
        return self.datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isFiltering {
            return get_option_cell(indexPath: indexPath)
        }
        
        let repoItem = self.datasource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewController.repositoryCellID, for: indexPath) as! RepoItemCell

        cell.configure(usingModel: repoItem)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isFiltering{
            return 44
        }
        return 101
    }
    
    
    func get_option_cell(indexPath: IndexPath)  -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as! OptionsCell
        var search_option = ""
        if isFiltering {
            search_option = self.query_options[indexPath.row]
        } else {
            search_option = self.api_options[indexPath.row]
        }
        cell.configure(withOptions: search_option)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering {
            let searchBar = searchController.searchBar
            let keywords = searchBar.text!.components(separatedBy: " ")
            switch indexPath.row {
            case 0: break
                //presenter -> router search reponame
                
            case 2:
                presenter.searchRepos(for: keywords, with: ["in":"description"])
            default:
                print("search query not found")
            }
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let lastElement = self.datasource.count - 1
        if indexPath.row == lastElement {
            // presente -> getNextPage -> interactor -> gitservie
        }
    }
    
}

//MARK: View Protocol 
extension MainViewController: MainView {
    
    func updateResults(repoList: [RepositoryItemViewModel], pagination: [String:String]) {
        print(repoList)
        //The fatched data is received here
        //update Table View
        self.pagination = pagination
        self.datasource = repoList
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
    
    
    func filterContentForSearchText(_ searchText: String) {
        query_options = []
        for option in api_options{
            query_options.append(option + searchText)
        }
        tableView.reloadData()
    }
}
