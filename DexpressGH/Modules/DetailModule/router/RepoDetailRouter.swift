//
//  RepoDetailRouter.swift
//  DexpressGH
//
//  Created by Tracer on 03/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit
import Foundation

protocol RepoDetailRouterInterface {
}

class RepoDetailRouter {
    weak var view: RepoDetailViewInterface?
}

extension RepoDetailRouter: RepoDetailRouterInterface {
}
