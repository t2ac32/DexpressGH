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
    func getRepositories(for keywords: [String], with qualifiers: [String: String], completion: @escaping(RepositoriesClosure))
    func getNextPage(pagination: String, completion: @escaping(RepositoriesClosure))
}

class MainViewInteractor {
    var service: GitHubApi
    //inyect the protocl not the full service
    init(service: GitHubApi) {
        self.service = service
    }
}

extension MainViewInteractor: MainViewInteractorInput {
    func getRepositories(for keywords: [String], with qualifiers: [String: String], completion: @escaping (RepositoriesClosure)) {
        self.service.fetchRepositories(keywords: keywords, with: qualifiers) { (repositories, pagination) -> Void in
            completion(repositories, pagination)
        }
    }
    func getNextPage(pagination: String, completion: @escaping (RepositoriesClosure)) {
        //TODO: SEND RESULTS TO VIE
        self.service.fetchNextPage(link: pagination) { (repositories, pagination) -> Void in
            completion(repositories, pagination)
        }
    }
}
