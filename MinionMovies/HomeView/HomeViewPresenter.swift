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
    
    func show(items: [Movie]?)
    func showAlert(message: String, type: AlertType)
}

class HomeViewPresenter: HomeViewPresenterProtocol {
    var view: HomeViewProtocol?
    
    init(view: HomeViewProtocol?) {
        self.view = view
    }
    
    func show(items: [Movie]?) {
        guard let checkedItems = items else { return }
        
        var movies = [Movie]()
        
        for item in checkedItems {
            movies.append(item)
        }
        
        view?.movies = movies
    }
    
    func showAlert(message: String, type: AlertType) {
        view?.showAlert(message: message, type: type)
    }
}
