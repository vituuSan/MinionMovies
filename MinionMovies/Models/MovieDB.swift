//
//  MovieDB.swift
//  MinionMovies
//
//  Created by Vitor Costa on 25/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class MovieDB: Object {
    dynamic var id: String = ""
    dynamic var title: String?
    dynamic var year: String?
    dynamic var rated: String?
    dynamic var released: String?
    dynamic var runtime: String?
    dynamic var genre: String?
    dynamic var director: String?
    dynamic var writer: String?
    dynamic var actors: String?
    dynamic var plot: String?
    dynamic var language: String?
    dynamic var country: String?
    dynamic var awards: String?
    dynamic var poster: String?
    dynamic var metascore: String?
    dynamic var resolutionIs4k: Bool = false
    dynamic var hdr: Bool = false
    dynamic var trailer: String?
    dynamic var image: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
