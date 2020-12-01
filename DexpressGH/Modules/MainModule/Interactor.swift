//
//  Interactor.swift
//  DexpressGH
//
//  Created by Tracer on 28/11/20.
//  Copyright © 2020 Tracer. All rights reserved.
//

import Foundation

// MARK: Manipulates data and use cases, Handles input from presenter and sends it back again to presenter and then to viewcontroller.
protocol MainViewInteractorInput {
    func getRepositories(completion: @escaping(RepositoriesClosure)) -> (Void)
}


class MainViewInteractor {
    var service: GitHubApi
    
    //inyect the protocl not the full service
    init(service: GitHubApi) {
        self.service = service
    }
}

extension MainViewInteractor: MainViewInteractorInput {
    
    func getRepositories(completion: @escaping(Repositories) -> (Void)) {
        
        self.service.fetchTracerRepositories { (results) in
            completion(results)
        }
        /*
         self.service.fetchRepositoriesFromJson { (results) -> (Void) in
                completion(results)
        }
        */
        
    }
    
    
}
