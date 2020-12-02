//
//  MainPresenter.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

protocol MainPresentation {
    func viewDidLoad()
    func searchRepos(for keywords: [String], with qualifiers:[String: String])
    func loadNextPage(link: String)
}

class MainPresenter {
    weak var view: MainViewInterface?
    var interactor: MainViewInteractorInput?
    var router: MainViewRouting?
    init(interactor: MainViewInteractorInput, router: MainViewRouting) {
        self.interactor = interactor
        self.router = router
    }
    private func getRepoItem(items: [Item]) -> [RepositoryItemViewModel] {
        let repolist = items.compactMap({ RepositoryItemViewModel(using: $0) })
        return repolist
    }
}

extension MainPresenter: MainPresentation {
    //Mocks our view viewdidLoad method
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor?.getRepositories(for: [""], with: ["user": "t2ac32"], completion: {(results, pagination) in
                guard let items = results.items, items.count > 0 else {
                    print("No items in response")
                    return
                }
                let reposList = self!.getRepoItem(items: items)
                DispatchQueue.main.async {
                    self?.view?.updateResults(repoList: reposList, pagination: pagination)
                }
            })
        }
    }
    func searchRepos(for keywords: [String], with qualifiers:[String: String] ) {
        DispatchQueue.global(qos: .background).async {[weak self] in
            self?.interactor?.getRepositories(for: keywords, with: qualifiers, completion: { (results, pagination) -> Void in
                guard let items = results.items, items.count > 0 else {
                    print("Error Searching for Repos")
                    DispatchQueue.main.async {
                        self?.view?.noResultsFound()
                    }
                    return
                }
                let repolist = self!.getRepoItem(items: items)
                DispatchQueue.main.async {
                    self?.view?.updateResults(repoList: repolist, pagination: pagination)
                }
            })
        }
    }

    func loadNextPage(link: String) {
        //TODO: UPDATE Data Source
        print(link)
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor?.getNextPage(pagination: link, completion: { (results, pagination) -> Void in
                guard let items = results.items, items.count > 0 else {
                    print("No items in response")
                    return
                }
                let repolist = self!.getRepoItem(items: items)
                DispatchQueue.main.async {
                    self?.view?.updateResults(repoList: repolist, pagination: pagination)
                }
            })
        }
    }
}

struct RepositoryItemViewModel {
    let title: String
    let avatarUrl: String
    let description: String
    let followers: String
    let forks: String
    let watchers: String
    init(using repoModel: Item) {
        self.title = repoModel.name ?? ""
        self.avatarUrl = repoModel.owner?.avatarURL ?? "Na"
        self.description = repoModel.itemDescription ?? "No description found"
        self.followers = Double(repoModel.stargazersCount ?? 0).unitFormatted()
        self.forks =  Double(repoModel.forks ?? 0).unitFormatted()
        self.watchers = Double(repoModel.watchers ?? 0).unitFormatted()
    }
}
