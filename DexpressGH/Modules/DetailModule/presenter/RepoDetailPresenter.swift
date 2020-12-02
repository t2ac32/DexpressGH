//
//  RepoDetailPresenter.swift
//  DexpressGH
//
//  Created by Tracer on 02/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

protocol RepoDetailPresenterInterface {
    func viewDidLoad()
}

class RepoDetailPresenter {
    weak var view: RepoDetailViewInterface?
    var repo: RepositoryItemViewModel
    var interactor: RepoDetailInteractorInterface
    // TODO: Declare Router
    init(repo: RepositoryItemViewModel, interactor: RepoDetailInteractorInterface) {
        self.repo = repo
        self.interactor = interactor
    }
}

extension RepoDetailPresenter: RepoDetailPresenterInterface {
    func viewDidLoad() {
    }
}
