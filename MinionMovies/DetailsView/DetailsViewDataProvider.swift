//
//  DetailsViewDataProvider.swift
//  MinionMovies
//
//  Created by Vitor Costa on 14/05/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol DetailsViewDataProviderProtocol {
    func add(item: FavMovieDB)
    func delete(item: FavMovieDB)
    func check(item: FavMovieDB) -> Bool
}

class DetailsViewDataProvider: DetailsViewDataProviderProtocol {
    
    private var dbManager: DBManager
    
    init(dbManager: DBManager) {
        self.dbManager = dbManager
    }
    
    func add(item: FavMovieDB) {
        
    }
    
    func delete(item: FavMovieDB) {
        
    }
    
    func check(item: FavMovieDB) -> Bool {
        return dbManager.check(object: item, type: FavMovieDB.self)
    }
}
