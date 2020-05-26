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
    func searching(title: String)
}

class HomeViewInteractor: HomeViewInteractorProtocol {
    var presenter: HomeViewPresenterProtocol?
    var worker: HomeViewWorkerProtocol?
    var items: [MovieDB]?
    
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
                self?.items = receivedItems
                self?.presenter?.show(items: receivedItems)
            }
        })
    }
    
    func searching(title: String) {
        guard let checkedItems = items else { return }
        var itemsToPresent = [MovieDB]()
        for item in checkedItems {
            if item.title?.lowercased().contains(title.lowercased()) ?? false {
                itemsToPresent.append(item)
            }
        }
        
        if title != "" || itemsToPresent.count != 0 {
            presenter?.show(items: itemsToPresent)
        } else {
            presenter?.show(items: items)
        }
    }
}
