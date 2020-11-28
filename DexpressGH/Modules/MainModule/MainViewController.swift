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
    
    // Reference to presenter
    var presenter: MainPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.presenter?.viewDidLoad() 
    }
    
}

extension MainViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "repositoryCell", for: indexPath)
        
        return cell
        
    }

    
    
}

extension MainViewController: MainView{
    func updateResults(repoList: Repositories) {
        print("Repo list:\(String(describing: repoList.totalCount))")
        //The fatched data is received here
        //update Table View
        
    }
    
}
