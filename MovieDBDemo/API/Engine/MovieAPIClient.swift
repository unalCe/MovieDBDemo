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
    
    func getMovies(for listType: ListType, completion: @escaping MoviesCompletionHandler)
    func getDetails(for movie: Movie, completion: @escaping MovieDetailsCompletionHandler)
    // func getMoviesInCollection(for movieDetails: MovieDetail, completion: @escaping MoviesCompletionHandler)
}

class MovieAPIClient: MovieAPIClientProtocol {
    
    func getMovies(for listType: ListType, completion: @escaping MovieAPIClientProtocol.MoviesCompletionHandler) {
        var endPoint: APIEndPoints
        switch listType {
        case .NowPlaying: endPoint = .nowPlaying
        case .Popular: endPoint = .popular
        case .TopRated: endPoint = .topRated
        }
        
        guard let url = URL(string: endPoint.buildUrl()) else {
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
            
            if let response = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
                completion(response.results, nil)
                return
            } else {
                completion([], APIError.invalidResponse)
            }
        }
        
        dataTask.resume()
    }
    
    func getDetails(for movie: Movie, completion: @escaping MovieAPIClientProtocol.MovieDetailsCompletionHandler) {
        print("detay yok şimdilik")
    }
    
    
    
}


