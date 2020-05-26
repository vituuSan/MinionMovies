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
    func deleteMovie(with id: String)
    func checkMovie(with id: String) -> Bool
    func getMovie(with id: String) -> MovieDB
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
    
    func deleteMovie(with id: String) {
        let dbManager = DBManager(config: config)
        dbManager.delete(objectId: id, type: FavMovieDB.self)
    }
    
    func checkMovie(with id: String) -> Bool {
        let dbManager = DBManager(config: config)
        return dbManager.check(objectId: id, type: FavMovieDB.self)
    }
    
    func getMovie(with id: String) -> MovieDB {
        let dbManager = DBManager(config: config)
        return dbManager.retrieveSpecificItem(objectId: id, type: MovieDB.self) as! MovieDB
    }
}
