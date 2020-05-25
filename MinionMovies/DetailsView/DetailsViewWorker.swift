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
    func delete(item: String)
    func check(item: String) -> Bool
    func getItem(id: String) -> MovieDB
}

class DetailsViewWorker: DetailsViewWorkerProtocol {
    var dataProvider: DetailsViewDataProviderProtocol?
    
    init(dataProvider: DetailsViewDataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func add(item: FavMovieDB) {
        dataProvider?.add(item: item)
    }
    
    func delete(item: String) {
        dataProvider?.delete(item: item)
    }
    
    func check(item: String) -> Bool {
        return dataProvider?.check(item: item) ?? false
    }
    
    func getItem(id: String) -> MovieDB {
        return dataProvider?.getSpecificItem(with: id) ?? MovieDB()
    }
}