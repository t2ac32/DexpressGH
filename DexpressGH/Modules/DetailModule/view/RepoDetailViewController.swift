//
//  RepoDetailViewController.swift
//  DexpressGH
//
//  Created by Tracer on 02/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit

protocol RepoDetailViewInterface: class {
    
}
class RepoDetailViewController: UIViewController {
    private let tableView: UITableView = UITableView()
    private let repo: RepositoryItemViewModel
    init(repo: RepositoryItemViewModel) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setupView() {
        view.backgroundColor = .black
        guard let nbar = self.navigationController?.navigationBar else {
            return
        }
        nbar.isTranslucent = false
        nbar.barTintColor = .black
        nbar.titleTextAttributes = [.foregroundColor: UIColor.tracerGreen]
        self.title = "R"
    }
    func configTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        setupTableView()
    }
    func setupTableView() {
        tableView.backgroundColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        //Register custom cell nib
        view.addSubview(tableView)
    }
}

// MARK: Data Source
extension RepoDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoDetailCell", for: indexPath)
        return cell
    }
}
// MARK: Data Source Delegate
extension RepoDetailViewController: UITableViewDelegate {
}
