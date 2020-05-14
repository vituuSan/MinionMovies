//
//  DataProviderHomeView.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol HomeViewDataProviderProtocol {
    var dbManager: DBManager { get }
    
    func add(item: MovieDB)
}

class HomeViewDataProvider: HomeViewDataProviderProtocol {
    var dbManager: DBManager
    
    init(dbManager: DBManager) {
        self.dbManager = dbManager
    }
    
    func add(item: MovieDB) {
        dbManager.add(object: item)
    }
}
