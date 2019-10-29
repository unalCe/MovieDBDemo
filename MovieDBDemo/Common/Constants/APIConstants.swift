//
//  CellIdentifiers.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

struct MovieDBBaseAPI {
    static let TheMovieDBAPIKey = "381b8c0be715e4249021621d8c95ed62"
    static let BaseURL = "https://api.themoviedb.org/"
    static let BaseAPIVersion = "3/"
    static let BaseImagePath = "https://image.tmdb.org/t/p/w500/"
}

enum APIEndPoints {
    case nowPlaying
    case topRated
    case popular
    case movieDetails(movie: Movie)
    
    func endPoint() -> String {
        switch self {
        case .nowPlaying:
            return "now_playing"
        case .topRated:
            return "top_rated"
        case .popular:
            return "popular"
        case .movieDetails(let movie):
            return "\(movie.movieId)"
        }
    }
    
    func buildUrl(for content: ContentType) -> String {
        var conjunction: String
        switch content {
        case .Movie:
            conjunction = "movie/"
        default:
            conjunction = "tv/"
        }
        return "\(MovieDBBaseAPI.BaseURL)\(MovieDBBaseAPI.BaseAPIVersion)\(conjunction)\(endPoint())?api_key=\(MovieDBBaseAPI.TheMovieDBAPIKey)"
    }
}
