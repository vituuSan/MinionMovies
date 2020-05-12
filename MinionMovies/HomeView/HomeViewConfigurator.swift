//
//  HomeViewConfigurator.swift
//  MinionMovies
//
//  Created by Vitor Costa on 08/05/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

final class HomeViewConfigurator {
    
    static let sharedInstance = HomeViewConfigurator()
    
    func configure(viewController: HomeViewController) {
        let presenter = HomeViewPresenter(view: viewController)
        let interactor = HomeViewInteractor(presenter: presenter, worker: HomeViewWorker())
        
        interactor.worker?.dataProvider = HomeViewDataProvider(dbManager: DBManager(config: .basic))
        viewController.interactor = interactor
    }
}
