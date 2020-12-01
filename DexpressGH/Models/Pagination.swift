//
//  Pagination.swift
//  DexpressGH
//
//  Created by Tracer on 01/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

struct Pagination {
    let next, previous,first, last: String?
    
}
extension Pagination: Codable {
    init(dictionary: [String: String]) throws {
        self = try JSONDecoder().decode(Pagination.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    private enum CodingKeys: String, CodingKey {
        case next = "rel=\"next\""
        case previous = "rel=\"previous\""
        case first = "rel=\"first\""
        case last = "rel=\"last\""
    }
}
extension Pagination: CustomStringConvertible {
    var description: String {
        return "Next Page: \(next ?? "") \n " + "previous Page: \(previous ?? "") \n " + "first Page: \(first ?? "") \n" +  "\n last Page: \(last ?? "")"
    }
}
