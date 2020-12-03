//
//  RepoDetailInteractor.swift
//  DexpressGH
//
//  Created by Tracer on 03/12/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

protocol RepoDetailInteractorInterface: class {
}

class RepoDetailInteractor {
    weak var presenter: RepoDetailPresenter?
    init() {
    }
}

extension RepoDetailInteractor: RepoDetailInteractorInterface {
}
