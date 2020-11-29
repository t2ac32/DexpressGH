//
//  RequestBuilder.swift
//  DexpressGH
//
//  Created by Tracer on 29/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

class RequestBuilder {
    let endpoint: String = ""
    
    func requesetUrl(path: String) -> URL {
        return URL(string:  endpoint + path )!
    }
  
    //TODO: implement repos from username
    /*
    func repos(for userName: String) -> Repositories {
    }
    */
}
