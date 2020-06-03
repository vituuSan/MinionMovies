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
    func search(title: String)
}

class HomeViewInteractor: HomeViewInteractorProtocol {
    var presenter: HomeViewPresenterProtocol?
    var worker: HomeViewWorkerProtocol?
    
    init(presenter: HomeViewPresenterProtocol?, worker: HomeViewWorkerProtocol?) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func theScreenIsLoading() {
        worker?.makeGetRequest(urlString: "http://localhost:8080/response.json", completionHandler: { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let receivedItems):
                self?.presenter?.show(items: receivedItems)
            }
        })
    }
    
    func search(title: String) {
        let searchResult = (worker?.retrieveAllObjects().filter { $0.title?.lowercased().contains(title.lowercased()) ?? false }) ?? nil
        
        if title != "" || searchResult?.count != 0 {
            presenter?.show(items: searchResult)
        } else {
            presenter?.show(items: worker?.retrieveAllObjects())
        }
    }
}
