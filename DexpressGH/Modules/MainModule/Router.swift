//
//  Router.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit
import Foundation

protocol MainViewRouting {
    
}

class MainViewRouter {
    //instatiate the view to be routed
    var viewController: UIViewController
    
    init(view: UIViewController) {
        self.viewController = view
    }

}

extension MainViewRouter: MainViewRouting {
    
}
