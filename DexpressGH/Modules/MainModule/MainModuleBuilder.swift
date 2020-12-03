//
//  MainModuleBuilder.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation
import UIKit

class MainModuleBuilder {
    static func build() -> UIViewController {
        let interactor = MainViewInteractor(service: GitHubServiceImpl.shared)
        let router = MainViewRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let controller = MainViewController(presenter: presenter)
        router.view = controller
        presenter.view = controller
        interactor.presenter = presenter

        return controller
    }
}
