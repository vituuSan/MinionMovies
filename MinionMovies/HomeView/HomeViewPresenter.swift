//
//  HomeViewPresenter.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol HomeViewPresenterProtocol {
    var view: HomeViewProtocol? { get }
    
    func show(items: [MovieDB]?)
}

class HomeViewPresenter: HomeViewPresenterProtocol {
    var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol?) {
        self.view = view
    }
    
    func show(items: [MovieDB]?) {
        guard let checkedItems = items else { return }
        
        var homeViewModel = [HomeViewModel]()
        
        for item in checkedItems {
            homeViewModel.append(HomeViewModel(id: item.id, title: item.title!, poster: item.poster!))
        }
        
        view?.movies = homeViewModel
    }
}
