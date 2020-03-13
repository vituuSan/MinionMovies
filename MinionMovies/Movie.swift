//
//  File.swift
//  MinionMovies
//
//  Created by Vitor Costa on 02/03/20.
//  Copyright © 2020 Vitor Costa. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let metascore: String
    let resolutionIs4k: Bool
    let hdr: Bool
    let trailer: URL?
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case title, year, rated, released, runtime, genre, director, writer, actors, plot, language, country, awards, poster, metascore
        case resolutionIs4k = "4k"
        case hdr, trailer, images
    }
}
