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
    
    func show(items: [MovieDB]?)
}

class HomeViewPresenter: PresenterProtocol {
    var view: ViewProtocol?
    
    init(view: ViewProtocol?) {
        self.view = view
    }
    
    func show(items: [MovieDB]?) {
        guard let checkedItems = items else { return }
        
        var homeViewModel = [HomeViewModel]()
        
        for item in checkedItems {
            homeViewModel.append(HomeViewModel(title: item.title!, poster: item.poster!))
        }
        
        view?.movies = homeViewModel
    }
}
