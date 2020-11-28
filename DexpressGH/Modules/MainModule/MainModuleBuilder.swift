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
    
    func build() -> UIViewController {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "MainViewController") as! MainViewController
        
        let interactor = MainViewInteractor()
        let router = MainViewRouter(view: view)
        let presenter = MainPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        return view
    }
}
