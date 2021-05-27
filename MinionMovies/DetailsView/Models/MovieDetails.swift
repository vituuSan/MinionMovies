//
//  MovieDetails.swift
//  MinionMovies
//
//  Created by Vitor Costa on 10/05/21.
//  Copyright © 2021 Vitor Costa. All rights reserved.
//

import Foundation

class MovieDetails: Codable {
    var id: Int? = 0
    var title: String? = ""
    var overview: String? = ""
    var release: String? = ""
    var average: Double? = 0.0
    var voteCount: Int? = 0
    var poster: String? = ""
    var homepage: String? = ""
    var genres: [Genres] = []
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case release = "release_date"
        case average = "vote_average"
        case voteCount = "vote_count"
        case poster = "backdrop_path"
        case homepage
        case genres
    }
}

class Genres: Codable {
    var id: Int? = 0
    var name: String? = ""
}
