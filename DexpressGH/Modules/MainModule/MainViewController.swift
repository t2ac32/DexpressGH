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

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private static let repositoryCellID = "repoItemCell"
    
    var datasource: [RepositoryItemViewModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // Reference to presenter
    var presenter: MainPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view.
        self.presenter?.viewDidLoad()
        //self.tableView.register(UINib(nibName: "RepoItemCell", bundle: nil), forCellReuseIdentifier: MainViewController.repositoryCellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
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

    
}

extension MainViewController: MainView {
    
    func updateResults(repoList: [RepositoryItemViewModel]) {
        print("Repo list size: \(repoList.count)")
        print(repoList)
        //The fatched data is received here
        //update Table View
        self.datasource = repoList
        
        
        
    }
    
}
