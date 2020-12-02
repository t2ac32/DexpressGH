//
//  ResponseExtension.swift
//  DexpressGH
//
//  Created by Tracer on 01/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    func extractPagination(with header: String) -> Pagination {
        if #available(iOS 13.0, *) {
            guard let headerValue = self.value(forHTTPHeaderField: header) else {
                return Pagination(next: nil, previous: nil, first: nil, last: nil)
            }
            return createPagination(with: headerValue)
        } else {
            // Fallback on earlier versions
            guard let headerValue = self.allHeaderFields[header] as? String else {
                return Pagination(next: nil, previous: nil, first: nil, last: nil)
            }
            return createPagination(with: headerValue)
        }
    }
    func createPagination(with linkHeader: String) -> Pagination {
        let links = linkHeader.components(separatedBy: ",")
        var paginationLinks: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy: "; ")
            var cleanPath = components[0].trimmingCharacters(in: .whitespaces)
            cleanPath = cleanPath.trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            paginationLinks[components[1]] = cleanPath
        })
        if let pagination = try? Pagination(dictionary: paginationLinks) { return pagination}
        return Pagination(next: nil, previous: nil, first: nil, last: nil)
    }
}
