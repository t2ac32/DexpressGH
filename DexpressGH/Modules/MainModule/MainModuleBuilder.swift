//
//  MainModuleBuilder.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import UIKit
import Foundation

class MainModuleBuilder {
    
    static func build() -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        
        let router = MainViewRouter(view: view)
        let interactor = MainViewInteractor(service: GitHubServiceImpl.shared)
        let presenter = MainPresenter(interactor: interactor, router: router)
        let controller = MainViewController(presenter: presenter)
        
        
        
        presenter.view = controller
        return controller
    }
}

