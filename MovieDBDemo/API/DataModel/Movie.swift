//
//  Movie.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

protocol MovieProtocol: Codable {
    var movieId: Int { get set }
    var title: String { get set }
    var overview: String { get set }
    var posterPath: String { get set }
    var voteAverage: Double { get set }
    var backDropPath: String { get set }
}

extension MovieProtocol {
    func getPosterUrl() -> String {
        return "\(MovieDBBaseAPI.BaseImagePath)\(posterPath)"
    }
    
    func getBackDropURL() -> String {
        return "\(MovieDBBaseAPI.BaseImagePath)\(backDropPath)"
    }
}

struct Movie: MovieProtocol {
    var movieId: Int
    var title: String
    var overview: String
    var posterPath: String
    var voteAverage: Double
    var backDropPath: String
    
    private enum CodingKeys : String, CodingKey {
        case movieId = "id", title, overview, posterPath = "poster_path", voteAverage = "vote_average", backDropPath = "backdrop_path"
    }
}
