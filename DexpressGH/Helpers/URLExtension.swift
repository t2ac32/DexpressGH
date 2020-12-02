//
//  URLExtension.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable, U: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, U?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, nil)
                return
            }
            if let repos = try? newJSONDecoder().decode(T?.self, from: data) {
                completionHandler(repos, response, nil)
            } else {
                completionHandler(nil, response, try? newJSONDecoder().decode(U.self, from: data))
            }
        }
    }

    func repositoriesTask(with url: URL, completionHandler: @escaping (Repositories?, URLResponse?, ResponseError?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }

}
