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
    // MARK: Interactor
    // MARK: Router
    
    init(repo: RepositoryItemViewModel) {
        self.repo = repo
    }
}

extension RepoDetailPresenter: RepoDetailPresenterInterface {
    func viewDidLoad() {
        
    }
}
