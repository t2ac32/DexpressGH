//
//  GithubService.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

typealias RepositoriesClosure = (Repositories, Pagination ) -> (Void)
typealias LocalRepositoryClosure = (Repositories) -> (Void)

protocol GitHubApi {
    var endpoint: String { get }
    func fetchRepositories(keywords:[String], with qualifiers: [String:String], completion: @escaping(RepositoriesClosure)) -> (Void)
    func fetchRepositoriesFromJson( completion: @escaping(LocalRepositoryClosure)) -> (Void)
    func fetchTracerRepositories( completion: @escaping(RepositoriesClosure)) -> (Void)
    func fetchNextPage(link:String, completion: @escaping(RepositoriesClosure)) -> (Void)

}

class GitHubServiceImpl {
    internal let endpoint: String = "https://api.github.com/search/repositories?q="
    
    static let shared: GitHubServiceImpl = GitHubServiceImpl()
    
    func requestUrl(path: String) -> URL? {
        if path.contains(endpoint) {
            if let url = URL(string: path) {
                return url
            }
            
        }
        guard let url = URL(string: endpoint + path) else {
            return nil
        }
        return url
    }
    func buildPath(from keywords: [String], qualifiers:[String:String]) -> String {
        var path:String = ""
        path = keywords.joined(separator: "+")
        if qualifiers.isEmpty == false {
            for key in qualifiers.keys {
                guard let qualifier = qualifiers[key] else {
                    print("error appending qualifier value")
                    return path
                }
                let query = "+" + key + ":" + qualifier
                path.append(query)
            }
        }
        return path
    }
    
}

extension GitHubServiceImpl: GitHubApi {
        
    func getReposUrl(from user:String) -> URL? {
        let path = "user:\(user)"
        guard let url = requestUrl(path: path) else {
            return nil
        }
        return url
    }
    
    func get_tracer_repos() -> URL? {
        guard let url = getReposUrl(from:
            "istornz") else{
            return nil
        }
        return url
    }
    
    func fetchTracerRepositories(completion: @escaping (RepositoriesClosure)) {
        guard let url = get_tracer_repos() else {
            return 
        }
        print("URL Path: ", url.absoluteString)
        
        let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
            guard let repositories = repositories else{
                print("Error fetching repositories")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let paginationDict =
                httpResponse.extractPagination(with: "Link")
                completion(repositories, paginationDict)
            }
        }
        task.resume()
    }
    
    func fetchRepositories(keywords: [String], with qualifiers: [String : String], completion: @escaping (RepositoriesClosure)) {
        let path = buildPath(from: keywords, qualifiers: qualifiers)
        guard let url = requestUrl(path: path) else{
            print("Error getting Request URL")
            return
        }
        print("URL Path: ", url.absoluteString)
        
        let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
            guard let repositories = repositories else{
                print("Error fetching repositories")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let paginationDict =
                httpResponse.extractPagination(with: "Link")
                completion(repositories, paginationDict)
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
    
    func fetchNextPage(link: String, completion: @escaping (RepositoriesClosure)) {
        guard let url = self.requestUrl(path: link) else {
            return
        }
        let task = URLSession.shared.repositoriesTask(with: url) { repositories, response, error in
            guard let repositories = repositories else{
                print("Error fetching Next Page")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let paginationDict =
                httpResponse.extractPagination(with: "Link")
                completion(repositories, paginationDict)
            }
        }
        task.resume()
    }
    
    
    
}
