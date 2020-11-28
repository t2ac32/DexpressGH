//
//  Interactor.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

// MARK: Manipulates data and use cases, Handles input from presenter and sends it to the viewcontroller.
protocol MainViewInteractorInput {
    func getRepositories() -> Repositories
}


class MainViewInteractor {
    
}

extension MainViewInteractor: MainViewInteractorInput {
    
    func getRepositories() -> Repositories {
        return Repositories(totalCount: 10, incompleteResults: false, items: g)
    }
}
