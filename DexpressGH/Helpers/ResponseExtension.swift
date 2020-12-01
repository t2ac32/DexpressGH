//
//  ResponseExtension.swift
//  DexpressGH
//
//  Created by Tracer on 01/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    func extractPagination(with header : String) -> [String:String]{
        guard let linkHeader = self.value(forHTTPHeaderField: header) else {
            return [:]
        }
        
        let links = linkHeader.components(separatedBy: ",")

        var pagination_links: [String: String] = [:]
        links.forEach({
            let components = $0.components(separatedBy:"; ")
            let cleanPath = components[0].trimmingCharacters(in: CharacterSet(charactersIn: "<>"))
            pagination_links[components[1]] = cleanPath
        })
        var pagination: [String:String] = [:]
        if let prevPagePath = pagination_links["rel=\"previous\""] {
            pagination["prev"] = prevPagePath
        }
        if let nextPagePath = pagination_links["rel=\"next\""] {
            pagination["next"] = nextPagePath
        }
        if let firstPagePath = pagination_links["rel=\"first\""]{
            pagination["first"] = firstPagePath
        }
        if let lastPagePath = pagination_links["rel=\"last\""]{
            pagination["last"] = lastPagePath
        }
        
        return pagination
    }
    

    
}
