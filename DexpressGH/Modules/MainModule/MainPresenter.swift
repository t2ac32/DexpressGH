//
//  MainPresenter.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

protocol MainPresentation {
    func viewDidLoad() -> Void
}

class MainPresenter {
    
    var interactor: MainViewInteractorInput
    var router: MainViewRouting
    
    init(interactor: MainViewInteractorInput, router: MainViewRouting) {
        self.interactor = interactor
        self.router = router
    }
}


extension MainPresenter: MainPresentation {
 
    func viewDidLoad() {
        
    }
}
