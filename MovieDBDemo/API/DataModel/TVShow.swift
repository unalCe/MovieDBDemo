//
//  TVShow.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 29.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

protocol TVShowProtocol: Codable {
    var showId: Int { get set }
    var name: String { get set }
    var overview: String { get set }
    var posterPath: String { get set }
    var releaseDate: String { get set }
    var voteAverage: Double { get set }
    var backDropPath: String { get set }
}

extension TVShowProtocol {
    func getPosterUrl() -> String {
        return "\(MovieDBBaseAPI.BaseImagePath)\(posterPath)"
    }
    
    func getBackDropURL() -> String {
        return "\(MovieDBBaseAPI.BaseImagePath)\(backDropPath)"
    }
}

class TVShow: TVShowProtocol {
    var showId: Int
    var name: String
    var overview: String
    var posterPath: String
    var releaseDate: String
    var voteAverage: Double
    var backDropPath: String
    
    private enum CodingKeys: String, CodingKey {
        case showId = "id", name, overview, posterPath = "poster_path", voteAverage = "vote_average", backDropPath = "backdrop_path", releaseDate = "first_air_date"
    }
}
