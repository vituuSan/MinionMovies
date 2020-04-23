//
//  DBManagerFavorites.swift
//  MinionMovies
//
//  Created by Vitor Costa on 20/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation
import RealmSwift

class DBManagerFavorites: DBManagerProtocol {
    func add(movie: Movie) {
        do {
            let realm = try Realm()
            let movieFav = FavMovieDB()
            
            movieFav.id = movie.id
            try realm.write{
                realm.add(movieFav, update: .modified)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func delete(movie: Movie) {
        do {
            let realm = try Realm()
            let result = realm.objects(FavMovieDB.self).filter("id = \"\(movie.id)\"")
            
            try realm.write{
                realm.delete(result)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func check(movie: Movie) -> Bool {
        do {
            let realm = try Realm()
            let result = realm.objects(FavMovieDB.self).filter("id = \"\(movie.id)\"")
            
            if result.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print(error)
            return false
        }
    }
}
