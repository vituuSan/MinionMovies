//
//  FavMovieDB.swift
//  MinionMovies
//
//  Created by Vitor Costa on 26/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class FavMovieDB: Object {
    dynamic var id: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
