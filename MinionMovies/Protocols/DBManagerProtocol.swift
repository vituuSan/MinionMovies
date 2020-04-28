//
//  DBManagersProtocols.swift
//  MinionMovies
//
//  Created by Vitor Costa on 20/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation
import RealmSwift

protocol DBManagerProtocol {
    func add(movie: Object)
    func delete(movie: Object)
    func check(movie: Object) -> Bool
}
