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
    func delete(item: String)
    func check(item: String) -> Bool
    func getSpecificItem(with id: String) -> MovieDB
}

class DetailsViewDataProvider: DetailsViewDataProviderProtocol {
    
    private var config: ConfigurationType
    
    init(config: ConfigurationType) {
        self.config = config
    }
    
    func add(item: FavMovieDB) {
        let dbManager = DBManager(config: config)
        dbManager.add(object: item)
    }
    
    func delete(item: String) {
        let dbManager = DBManager(config: config)
        dbManager.delete(objectId: item, type: FavMovieDB.self)
    }
    
    func check(item: String) -> Bool {
        let dbManager = DBManager(config: config)
        return dbManager.check(objectId: item, type: FavMovieDB.self)
    }
    
    func getSpecificItem(with id: String) -> MovieDB {
        let dbManager = DBManager(config: config)
        return dbManager.retrieveSpecificItem(objectId: id, type: MovieDB.self) as! MovieDB
    }
}
