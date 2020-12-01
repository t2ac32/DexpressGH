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
    var endpoint: String { get }
    func fetchRepositoriesFromJson( completion: @escaping(RepositoriesClosure)) -> (Void)
    func fetchTracerRepositories( completion: @escaping(RepositoriesClosure)) -> (Void)

}

class GitHubServiceImpl {
    internal let endpoint: String = "https://api.github.com/search/repositories?q="
    
    static let shared: GitHubServiceImpl = GitHubServiceImpl()
    
    
}

extension GitHubServiceImpl: GitHubApi {
    func requestUrl(path: String) -> URL {
        return URL(string:  endpoint + path )!
    }
    
    func getReposUrl(from user:String) -> URL {
        let path = "user:\(user)"
        let url = requestUrl(path: path)
        return url
    }
    
    func get_tracer_repos() -> URL {
        return getReposUrl(from: "istornz")
    }
    
    func fetchTracerRepositories(completion: @escaping(Repositories) -> Void){
        let url = get_tracer_repos()
        print("URL Path: ", url.absoluteString)
        
        let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
             if let repositories = repositories {
                completion(repositories)
             }
        }
        task.resume()
    
    }
    
    
    func fetchRepositoriesFromJson(completion: @escaping(Repositories) -> Void) {
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
