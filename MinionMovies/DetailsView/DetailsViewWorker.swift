//
//  DetailsViewWorker.swift
//  MinionMovies
//
//  Created by Vitor Costa on 14/05/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol DetailsViewWorkerProtocol {
    var dataProvider: DetailsViewDataProviderProtocol? { get set }
    
    func add(item: FavMovieDB)
    func deleteMovie(with id: String)
    func checkMovie(with id: String) -> Bool
    func fetchMovie(with id: String) -> MovieDB
}

class DetailsViewWorker: DetailsViewWorkerProtocol {
    var dataProvider: DetailsViewDataProviderProtocol?
    
    init(dataProvider: DetailsViewDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func add(item: FavMovieDB) {
        dataProvider?.add(item: item)
    }
    
    func deleteMovie(with id: String) {
        dataProvider?.deleteMovie(with: id)
    }
    
    func checkMovie(with id: String) -> Bool {
        return dataProvider?.checkMovie(with: id) ?? false
    }
    
    func fetchMovie(with id: String) -> MovieDB {
        return dataProvider?.fetchMovie(with: id) ?? MovieDB()
    }
}
