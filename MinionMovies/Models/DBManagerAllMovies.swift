//
//  DBManageAllMovies.swift
//  MinionMovies
//
//  Created by Vitor Costa on 20/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation
import RealmSwift

class DBManagerAllMovies: DBManagerProtocol {
    
    func add(movie: Object) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(movie, update: .modified)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func delete(movie: Object) {
        do {
            let realm = try Realm()
            
            try realm.write{
                realm.delete(movie)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func check(movie: Object) -> Bool {
        
        // nao vai dar certo, provavelmente
        if movie.isEqual(MovieDB()) || movie.isEqual(FavMovieDB()) {
            return true
        } else {
            return false
        }
    }
}
