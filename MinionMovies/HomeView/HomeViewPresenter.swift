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
    
    func receiveItems(items: [MovieDB]?)
    func searchResult(string: String)
}

class HomeViewPresenter: PresenterProtocol {
    var view: ViewProtocol?
    private var items: [MovieDB] = []
    
    init(view: ViewProtocol?) {
        self.view = view
    }
    
    func receiveItems(items: [MovieDB]?) {
        guard let checkedItems = items else { return }
        
        self.items = checkedItems
        
        for item in self.items {
            let homeViewModel = HomeViewModel(title: item.title!, poster: item.poster!)
            view?.movies?.append(homeViewModel)
        }
    }
    
    func searchResult(string: String) {
        let auxItems = view?.movies
        
        view?.filteredMovies = auxItems?.filter({ $0.title.prefix(string.count) == string })
    }
}
