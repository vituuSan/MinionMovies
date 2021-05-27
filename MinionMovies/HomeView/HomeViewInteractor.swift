//
//  HomeViewInteractor.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol HomeViewInteractorProtocol {
    var presenter: HomeViewPresenterProtocol? { get }
    var worker: HomeViewWorkerProtocol? { get }
    
    func theScreenIsLoading()
}

class HomeViewInteractor: HomeViewInteractorProtocol {
    var presenter: HomeViewPresenterProtocol?
    var worker: HomeViewWorkerProtocol?
    
    init(presenter: HomeViewPresenterProtocol?, worker: HomeViewWorkerProtocol?) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func theScreenIsLoading() {
        let url = ServiceConstants.Discover.movie + MinionMoviesService.apiKey
        worker?.makeGetRequest(urlString: url,
                               completionHandler: { [weak self] result in
            switch result {
            case .success(let receivedItems):
                self?.presenter?.show(items: receivedItems)
            case .failure(let error):
                print(error.localizedDescription)
//                self?.presenter?.showAlert(message: error.localizedDescription, type: .error)
            }
        })
    }
}
