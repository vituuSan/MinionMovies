//
//  DBManagersProtocols.swift
//  MinionMovies
//
//  Created by Vitor Costa on 20/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol DBManagerProtocol {
    func add(movie: Movie)
    func delete(movie: Movie)
    func check(movie: Movie) -> Bool
}
