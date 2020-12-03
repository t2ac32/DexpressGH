//
//  MainPresenter.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//
import UIKit
import Foundation

protocol MainPresentation: class {
    func viewDidLoad()
    func searchRepos(for keywords: [String], with qualifiers: [Bool] )
    func requestNextPage(link: String)
    func loadResults(repositories: [Item], pagination: Pagination)
    func noResultsFound()
    func updateQueryOptions(searchText: String)
    func showRepoDetailController(navigationController: UINavigationController)
    func cancelSearch()
}

class MainPresenter {
    weak var view: MainViewInterface?
    var interactor: MainViewInteractorInput?
    var router: MainViewRouting?
    private var queryOptions: [String] = []
    private let apiOptions: [String] = ["Repos named ",
                                        "Repo owner is ",
                                        "Description contains ",
                                        "Read Me contains "]
    init(interactor: MainViewInteractorInterface, router: MainViewRoutingInterface) {
        self.interactor = interactor
        self.router = router
    }
    private func getRepoItem(items: [Item]) -> [RepositoryItemViewModel] {
        let repolist = items.compactMap({ RepositoryItemViewModel(using: $0) })
        return repolist
    }
    func showRepoDetailController(navigationController: UINavigationController) {
        router?.pushToRepoDetail(navigationConroller: navigationController)
    }
}

extension MainPresenter: MainPresentation {
    func viewDidLoad() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor?.getRepositories(for: ["t2ac32"], with: [false,
                                                                      true,
                                                                      false,
                                                                      false])
        }
    }
    func cancelSearch() {
        self.view?.reloadData(isFiltering: false)
    }
    func updateQueryOptions(searchText: String) {
        var queryOptions: [String] = []
        for option in apiOptions {
            queryOptions.append(option + searchText)
        }
        self.view?.updateQueryOptions(options: queryOptions)
        self.view?.reloadData(isFiltering: true)
    }
    func searchRepos(for keywords: [String], with qualifiers: [Bool] ) {
        DispatchQueue.main.async {
            self.view?.reloadData(isFiltering: false)
            self.view?.showTableLoader()
        }
        DispatchQueue.global(qos: .background).async {[weak self] in
            self?.interactor?.getRepositories(for: keywords, with: qualifiers)
        }
    }
    func requestNextPage(link: String) {
        DispatchQueue.main.async {
            self.view?.showTableLoader()
        }
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.interactor?.getNextPage(pagination: link)
        }
    }
    func loadResults(repositories: [Item], pagination: Pagination) {
        let reposList = self.getRepoItem(items: repositories)
        DispatchQueue.main.async {
            self.view?.hideTableLoader()
            if pagination.previous != nil {
                self.view?.setDataSource(repoList: reposList)
            } else {
                self.view?.updateDataSource(repoList: reposList)
            }
            self.view?.updatePagination(pagination: pagination)
            self.view?.resultsFound(didFound: true)
            self.view?.dismissSearch()
            self.view?.reloadData(isFiltering: false)
        }
    }
    func noResultsFound() {
        DispatchQueue.main.async {
            self.view?.resultsFound(didFound: false)
            self.view?.hideTableLoader()
        }
    }
}

struct RepositoryItemViewModel {
    let title: String
    let avatarUrl: String
    let description: String
    let followers: String?
    let forks: String?
    let watchers: String?
    init(using repoModel: Item) {
        self.title = repoModel.name ?? ""
        self.avatarUrl = repoModel.owner?.avatarURL ?? "Na"
        self.description = repoModel.itemDescription ?? "No description found"
        if repoModel.stargazersCount != 0 {
            self.followers = Double(repoModel.stargazersCount ?? 0).unitFormatted()
        } else { self.followers = nil }
        if repoModel.forks != 0 {
            self.forks = Double(repoModel.forks ?? 0).unitFormatted()
        } else { self.forks = nil }
        if repoModel.watchers != 0 {
            self.watchers =  Double(repoModel.watchers ?? 0).unitFormatted()
        } else { self.watchers = nil }
    }
}
