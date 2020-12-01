//
//  GithubService.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

typealias RepositoriesClosure = (Repositories, [String:String] ) -> (Void)
typealias LocalRepositoryClosure = (Repositories) -> (Void)

protocol GitHubApi {
    var endpoint: String { get }
    func fetchRepositories(keywords:[String], with qualifiers: [String:String], completion: @escaping(RepositoriesClosure)) -> (Void)
    func fetchRepositoriesFromJson( completion: @escaping(LocalRepositoryClosure)) -> (Void)
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
    
    func buildPath(from keywords: [String], qualifiers:[String:String]) -> String{
        var path:String = ""
        path = keywords.joined(separator: "+")
        if qualifiers.isEmpty == false {
            for k in qualifiers.keys {
                guard let qualifier = qualifiers[k] else {
                    print("error appending qualifier value")
                    return path
                }
                let q = "+" + k + ":" + qualifier
                path.append(q)
            }
        }
        return path
    }
        
    
    func getReposUrl(from user:String) -> URL {
        let path = "user:\(user)"
        let url = requestUrl(path: path)
        return url
    }
    
    func get_tracer_repos() -> URL {
        return getReposUrl(from: "istornz")
    }
    
    func fetchTracerRepositories(completion: @escaping (RepositoriesClosure)) {
        let url = get_tracer_repos()
        print("URL Path: ", url.absoluteString)
        
        let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
            guard let repositories = repositories else{
                print("Error fetching repositories")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let pagination_dict =
                httpResponse.extractPagination(with: "Link")
                completion(repositories, pagination_dict)
            }
            
            
        }
        task.resume()
    
    }
    
    func fetchRepositories(keywords: [String], with qualifiers: [String : String], completion: @escaping (RepositoriesClosure)) {
        let path = buildPath(from: keywords, qualifiers: qualifiers)
        let url = requestUrl(path: path)
        print("URL Path: ", url.absoluteString)
        
        let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
            guard let repositories = repositories else{
                print("Error fetching repositories")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let pagination_dict =
                httpResponse.extractPagination(with: "Link")
                completion(repositories, pagination_dict)
            }
            
                
        }
        task.resume()
        
    }
    
    func fetchRepositoriesFromJson(completion: (LocalRepositoryClosure)) {
        
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
