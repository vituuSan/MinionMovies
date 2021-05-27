//
//  ServiceConstants.swift
//  MinionMovies
//
//  Created by Vitor Costa on 12/05/21.
//  Copyright © 2021 Vitor Costa. All rights reserved.
//

import Foundation

struct ServiceConstants {
    static let baseURL = "https://api.themoviedb.org"
    static let basePathImage = "http://image.tmdb.org/t/p/w500"
    
    struct Version {
        static let v3 = "/3"
    }
    
    struct Discover {
        static var movie: String {
            return ServiceConstants.baseURL + ServiceConstants.Version.v3 + "/discover/movie"
        }
    }
}
