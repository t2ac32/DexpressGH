//
//  Enums.swift
//  DexpressGH
//
//  Created by Tracer on 30/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

enum Login: String, Codable {
    case t2Ac32 = "t2ac32"
}

enum GHApiErrors: Swift.Error {
    typealias RawValue = NSError
    case urlBuildError
    case fetchError
    case outOfStock
}
