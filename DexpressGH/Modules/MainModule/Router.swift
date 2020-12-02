//
//  Router.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit
import Foundation

// MARK: Handle NAVIGATION Between screens.
protocol MainViewRouting {
}

class MainViewRouter {
    //instatiate the view to be routed
    weak var view: MainViewInterface?
}

extension MainViewRouter: MainViewRouting {
}
