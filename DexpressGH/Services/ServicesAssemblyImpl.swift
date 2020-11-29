//
//  ServicesAssemblyImpl.swift
//  DexpressGH
//
//  Created by Tracer on 29/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit

class ServicesAssemblyImpl: ServicesAssemblyProtocol {
    
    let application: UIApplication
    //All available services should be here:
    let githubService: GitHubApi
    
    init(application: UIApplication) {
        self.application = application
        githubService = GitHubServiceImpl()
        
    }
}
