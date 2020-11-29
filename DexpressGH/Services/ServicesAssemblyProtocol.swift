//
//  ServicesAssemblyProtocol.swift
//  DexpressGH
//
//  Created by Tracer on 29/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit

protocol ServicesAssemblyProtocol {
    var application: UIApplication { get }
    var githubService: GitHubApi { get }
}
