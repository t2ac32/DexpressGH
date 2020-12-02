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
        guard let linkHeader = self.value(forHTTPHeaderField: header) else {
            return Pagination(next: nil, previous: nil, first: nil, last: nil)
        }
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
