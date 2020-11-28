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
        
        let interactor = MainViewInteractor(service: GitHubService.shared)
        let router = MainViewRouter(view: view)
        let presenter = MainPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        return view
    }
}
