//
//  RepoDetailPresenter.swift
//  DexpressGH
//
//  Created by Tracer on 02/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//
import UIKit
import Foundation

protocol RepoDetailPresenterInterface: class {
    func viewDidLoad()
}

class RepoDetailPresenter {
    weak var view: RepoDetailViewInterface?
    var repo: RepositoryItemViewModel?
    var interactor: RepoDetailInteractorInterface?
    var router: RepoDetailRouterInterface?
    init(repo: RepositoryItemViewModel, interactor: RepoDetailInteractorInterface, router: RepoDetailRouterInterface) {
        self.repo = repo
        self.interactor = interactor
        self.router = router
    }
}

extension RepoDetailPresenter: RepoDetailPresenterInterface {
    func viewDidLoad() {
    }
}
