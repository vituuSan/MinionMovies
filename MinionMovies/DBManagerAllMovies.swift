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
    func add(movie: Movie) {
        let movieDB = MovieDB()

        movieDB.id = movie.id
        movieDB.title = movie.title
        movieDB.year = movie.year
        movieDB.rated = movie.rated
        movieDB.released = movie.released
        movieDB.runtime = movie.runtime
        movieDB.genre = movie.genre
        movieDB.director = movie.director
        movieDB.writer = movie.writer
        movieDB.actors = movie.actors
        movieDB.plot = movie.plot
        movieDB.awards = movie.awards
        movieDB.metascore = movie.metascore
        movieDB.resolutionIs4k = movie.resolutionIs4k
        movieDB.hdr = movie.hdr
        movieDB.trailer = movie.trailer
        movieDB.image = movie.images.first

        do {
            let realm = try Realm()

            try realm.write {
                realm.add(movieDB, update: .modified)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func delete(movie: Movie) {
        do {
            let realm = try Realm()
            let result = realm.objects(MovieDB.self).filter("id = \"\(movie.id)\"")
            
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
            let result = realm.objects(MovieDB.self).filter("id = \"\(movie.id)\"")
            
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
