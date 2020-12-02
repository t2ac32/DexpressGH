//
//  Interactor.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

// MARK: Manipulates data and use cases
protocol MainViewInteractorInput {
    func getRepositories(for keywords: [String], with qualifiers: [String: String])
    func getNextPage(pagination: String)
}

class MainViewInteractor {
    var service: GitHubApi
    weak var presenter: MainPresentation?
    //inyect the protocl not the full service
    init(service: GitHubApi) {
        self.service = service
    }
    func fetchRepositories(from path: String) {
        self.service.fetchRepositories(from: path) { (repositories, pagination) in
            guard let items = repositories.items, items.count > 0 else {
                self.presenter?.noResultsFound()
                return
            }
            self.presenter?.loadResults(repositories: items, pagination: pagination)
        }
    }
}

extension MainViewInteractor: MainViewInteractorInput {
    func getRepositories(for keywords: [String], with qualifiers: [String: String]) {
        let path = self.service.buildPath(from: keywords, qualifiers: qualifiers)
        fetchRepositories(from: path)
    }
    func getNextPage(pagination: String) {
        self.fetchRepositories(from: pagination)
    }
}
