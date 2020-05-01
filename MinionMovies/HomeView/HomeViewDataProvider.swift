//
//  DataProviderHomeView.swift
//  MinionMovies
//
//  Created by Vitor Costa on 29/04/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    var worker: WorkerProtocol? { get }
}

class HomeViewDataProvider: DataProviderProtocol {
    var worker: WorkerProtocol? = nil
}
