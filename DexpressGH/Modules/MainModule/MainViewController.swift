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
    func updateResults(repoList: [RepositoryItemViewModel]) -> ()
}

class MainViewController: UIViewController, UISearchBarDelegate {
    
    // Reference to presenter
    private var presenter: MainPresentation
    private var tableView: UITableView = { return UITableView() }()
    
    private let navItem = UINavigationItem(title: "Home")
    
    
    
    
    
    
    private static let repositoryCellID = "repoItemCell"
    
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
        setupView()
        configTableView()
        // Do additional setup after loading the view.
        presenter.viewDidLoad()
        
    }
    
    func setupView(){
        let searchBar: UISearchBar = UISearchBar()
        view.backgroundColor = .black
        guard let nbar = self.navigationController?.navigationBar else {
            return
        }
        nbar.barTintColor = .black
        nbar.titleTextAttributes = [.foregroundColor: UIColor(red: 0.18, green: 0.80, blue: 0.44, alpha: 1.00)]
        self.title = "Home"
        
        searchBar.placeholder = "Search Github"
        searchBar.searchBarStyle = .prominent
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
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
        return self.datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoItem = self.datasource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewController.repositoryCellID, for: indexPath) as! RepoItemCell

        cell.configure(usingModel: repoItem)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    
    
}

extension MainViewController: MainView {
    
    func updateResults(repoList: [RepositoryItemViewModel]) {
        print(repoList)
        //The fatched data is received here
        //update Table View
        self.datasource = repoList
    }
    
}
