//
//  RepoDetailModuleBuilder.swift
//  DexpressGH
//
//  Created by Tracer on 03/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation
import UIKit

class RepoDetailModuleBuilder {
    static func build(repo: RepositoryItemViewModel) -> UIViewController {
        let repo = repo
        let interactor = RepoDetailInteractor()
        let router = RepoDetailRouter()
        let presenter = RepoDetailPresenter(repo: repo, interactor: interactor, router: router)
        let controller = RepoDetailViewController(repo: repo, presenter: presenter)
        router.view = controller as? RepoDetailViewInterface
        presenter.view = controller as? RepoDetailViewInterface
        interactor.presenter = presenter
        return controller
    }
}
