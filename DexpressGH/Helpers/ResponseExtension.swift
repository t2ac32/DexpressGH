//
//  ResponseExtension.swift
//  DexpressGH
//
//  Created by Tracer on 01/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    func extractPagination(with header : String) -> Pagination{
        guard let linkHeader = self.value(forHTTPHeaderField: header) else {
            return Pagination(next: nil, previous: nil, first: nil, last: nil)
        }
        
        let links = linkHeader.components(separatedBy: ",")

        var pagination_links: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy:"; ")
            let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            pagination_links[components[1]] = cleanPath
        })
        
        if let pagination = try? Pagination(dictionary: pagination_links) { return pagination}
        
        return Pagination(next: nil, previous: nil, first: nil, last: nil)
    }
    

    
}
