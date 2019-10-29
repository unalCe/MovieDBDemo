//
//  APIEngine.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 27.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

protocol MovieAPIClientProtocol {
    typealias MoviesCompletionHandler = ([Movie], Error?) -> Void
    typealias MovieDetailsCompletionHandler = (MovieDetail?, Error?) -> Void
    
    func getMovies(for content: ContentType, with listType: ListType, completion: @escaping MoviesCompletionHandler)
    func getDetails(for movie: Movie, with type: ContentType, completion: @escaping MovieDetailsCompletionHandler)
}

class MovieAPIClient: MovieAPIClientProtocol {
    
    func getMovies(for content: ContentType, with listType: ListType, completion: @escaping MovieAPIClientProtocol.MoviesCompletionHandler) {
        var endPoint: APIEndPoints
        switch listType {
        case .NowPlaying: endPoint = .nowPlaying
        case .Popular: endPoint = .popular
        case .TopRated: endPoint = .topRated
        }
        
        guard let url = URL(string: endPoint.buildUrl(for: content)) else {
            completion([], APIError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion([], error)
                return
            }
            
            guard let data = data else {
                completion([], APIError.invalidData)
                return
            }
            
            if let movieResponse = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
                completion(movieResponse.results, nil)
                return
            } else if let showResponse = try? JSONDecoder().decode(TVShowResponse.self, from: data) {
                    // Convert tvshows array to movies array.
                    let movieResults = showResponse.results.map({ (show) -> Movie in
                        return Movie(movieId: show.showId, title: show.name, overview: show.overview, posterPath: show.posterPath, voteAverage: show.voteAverage, releaseDate: show.releaseDate, backDropPath: show.backDropPath)
                    })
                    completion(movieResults, nil)
                    return
            } else {
                completion([], APIError.invalidResponse)
            }
        }
        
        dataTask.resume()
    }
    
    func getDetails(for movie: Movie, with type: ContentType, completion: @escaping MovieAPIClientProtocol.MovieDetailsCompletionHandler) {
        
        guard let url = URL(string: APIEndPoints.movieDetails(movie: movie).buildUrl(for: type)) else {
            completion(nil, APIError.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, APIError.invalidData)
                return
            }
            
            if let movieResponse = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                completion(movieResponse, nil)
                return
            } else {
                completion(nil, APIError.invalidResponse)
            }
        }
        
        dataTask.resume()
        
    }
}


