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
    func fetchTracerRepositories( completion: @escaping(RepositoriesClosure)) -> (Void)

}

class GitHubServiceImpl {
    fileprivate let endpoint: String = "https://api.github.com/search/repositories?q="
    
    static let shared: GitHubServiceImpl = GitHubServiceImpl()
    
}

extension GitHubServiceImpl: GitHubApi {
    
    func requestUrl(path: String) -> URL {
        return URL(string:  endpoint + path )!
    }
    
    
    func get_tracer_repos() ->URL {
        return getReposUrl(from: "t2ac32")
    }
    
    func getReposUrl(from user:String) -> URL {
        let path = "user:\(user)"
        let url = requestUrl(path: path)
        return url
        
    }
    
    func fetchTracerRepositories(completion: @escaping(Repositories) -> (Void)){
        let url = get_tracer_repos()
        print("URL Path: ",url.absoluteString)
        let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
            if let repositories = repositories {
                completion(repositories)
            }
        }
       task.resume()

        
    }
    
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
    
    // To parse the JSON, add this file to your project and do:
    //
    //   let repositories = try? newJSONDecoder().decode(Repositories.self, from: jsonData)

    //
    // To read values from URLs:
    //
    
    
}
