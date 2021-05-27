//
//  Movie.swift
//  MinionMovies
//
//  Created by Vitor Costa on 09/05/21.
//  Copyright © 2021 Vitor Costa. All rights reserved.
//

import Foundation

class Movie: Codable {
    var id: Int? = 0
    var title: String? = ""
    var overview: String? = ""
    var release: String? = ""
    var average: Double? = 0.0
    var voteCount: Int? = 0
    var poster: String? = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case release = "release_date"
        case average = "vote_average"
        case voteCount = "vote_count"
        case poster = "poster_path"
    }
}
