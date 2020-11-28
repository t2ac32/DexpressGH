//
//  GithubService.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

typealias RepositoriesClosure = (Repositories) -> (Void)

protocol GitHubApi {
    func fetchAllRepositories( completion: RepositoriesClosure) -> (Void)
}

class GitHubService {
    static let shared: GitHubService = GitHubService()
    
}

extension GitHubService: GitHubApi {
    func fetchAllRepositories(completion: (Repositories) -> (Void)) {
        if let url = Bundle.main.url(forResource: "all-repos", withExtension: "json") {
            do { let data = try Data(contentsOf: url)
                let repositories = try JSONDecoder().decode(Repositories.self, from: data)
                completion(repositories)
                
            }catch {
                print("Could not get data from local json file")
            }
        }
    }
    
    
}
