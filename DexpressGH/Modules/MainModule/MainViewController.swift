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
    
    func updateResults(repoList: Repositories) -> ()
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private static let repositoryCellID = "repoItemCell"
    
    var datasource: [Repository] = []
    
    // Reference to presenter
    var presenter: MainPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view.
        self.presenter?.viewDidLoad()
        self.tableView.register(UINib(nibName: "RepoItemCel", bundle: nil), forCellReuseIdentifier: MainViewController.repositoryCellID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repoModel = datasource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewController.repositoryCellID, for: indexPath) as! RepoItemCell

        cell.configure(usingModel: repoModel)
        return cell
    }
}

extension MainViewController: MainView{
    func updateResults(repoList: Repositories) {
        if let total = repoList.items?.count{
                print("Repo list:\(total)")
            if total > 0 {
                if let items = repoList.items{
                    self.datasource = items
                    self.tableView.reloadData()
                }
                
            }
        }
        //The fatched data is received here
        //update Table View
        
    }
    
}
