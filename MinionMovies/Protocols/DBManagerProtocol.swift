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
    func add(object: Object)
    func delete(object: Object)
    func check(object: Object) -> Bool
}
