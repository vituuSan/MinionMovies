//
//  HomeViewPresenter.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol PresenterProtocol {
    var view: ViewProtocol? { get }
    
    func sizeList() -> Int
    func receiveItems(items: [MovieDB]?)
    func retrieveItems() -> [MovieDB]
}

class HomeViewPresenter: PresenterProtocol {
    var view: ViewProtocol?
    private var items: [MovieDB] = []
    
    init(view: ViewProtocol?) {
        self.view = view
    }
    
    func setup() {
        view = HomeViewController(interactor: HomeViewInteractor(presenter: self, worker: HomeViewWorker()))
    }
    
    func sizeList() -> Int {
        return items.count
    }
    
    func retrieveItems() -> [MovieDB] {
        return items
    }
    
    func receiveItems(items: [MovieDB]?) {
        guard let checkedItems = items else { return }
        self.items = checkedItems
    }
}
