//
//  MovieDetail.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 27.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    
    var genres: [Genre]
    var voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview, posterPath = "poster_path", genres, voteAverage = "vote_average"
    }
}

struct Genre: Codable {
    var id: Int
    var name: String
}
