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
    weak var view: MainView?
    var interactor: MainViewInteractorInput?
    var router: MainViewRouting?
    
    init(view: MainView ,interactor: MainViewInteractorInput, router: MainViewRouting) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}


extension MainPresenter: MainPresentation {
    //Mocks our view viewdidLoad method
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor?.getRepositories(completion: {(results) in
                if let repositories = results.items {
                    DispatchQueue.main.async {
                        self?.view?.updateResults(repoList: repositories)
                    }
                }
            })
            
        }
        
    }
}

struct RepositoryItemViewModel {
    let title: String
    let avatar_url: String
    let description: String
    let followers: String
    let forks: String
    let watchers: String
    
    init(using repoModel: Repository) {
        self.title = repoModel.name ?? ""
        self.avatar_url = repoModel.owner?.avatarURL ?? "Na"
        self.description = repoModel.itemDescription ?? ""
        self.followers = Double(repoModel.stargazersCount ?? 0).unitFormatted()
        self.forks =  Double(repoModel.forks ?? 0).unitFormatted()
        self.watchers = Double(repoModel.watchersCount ?? 0).unitFormatted()
        
        
    }
}
