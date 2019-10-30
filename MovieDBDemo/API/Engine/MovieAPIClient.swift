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
    typealias MovieGenresCompletionHandler = (MovieGenres?, Error?) -> Void
    typealias MovieVideosCompletionHandler = ([Video], Error?) -> Void
    typealias MovieCreditsCompletionHandler = ([Artist], Error?) -> Void
    
    func getMovies(for content: ContentType, with listType: ListType, completion: @escaping MoviesCompletionHandler)
    func getGenres(for movie: Movie, with type: ContentType, completion: @escaping MovieGenresCompletionHandler)
    func getVideos(for movie: Movie, with type: ContentType, completion: @escaping MovieVideosCompletionHandler)
    func getCredits(for movie: Movie, with type: ContentType, completion: @escaping MovieCreditsCompletionHandler)
    func getImage(for movie: Movie, landscape: Bool, completion: @escaping (Data)->Void)
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
    
    func getGenres(for movie: Movie, with type: ContentType, completion: @escaping MovieAPIClientProtocol.MovieGenresCompletionHandler) {
        
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
            
            if let movieResponse = try? JSONDecoder().decode(MovieGenres.self, from: data) {
                completion(movieResponse, nil)
                return
            } else {
                completion(nil, APIError.invalidResponse)
            }
        }
        
        dataTask.resume()
    }
    
    func getImage(for movie: Movie, landscape: Bool = false, completion: @escaping (Data) -> Void ) {
        guard let imageURL = URL(string: landscape ? movie.getBackDropURL() : movie.getPosterUrl()) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async() {
                completion(data)
            }
        }
        dataTask.resume()
    }
    
    func getVideos(for movie: Movie, with type: ContentType, completion: @escaping MovieAPIClient.MovieVideosCompletionHandler) {
        guard let videosURL = URL(string: APIEndPoints.movieVideos(movie: movie).buildUrl(for: type)) else { return }
        
        
        let request = URLRequest(url: videosURL)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion([], error)
                return
            }
            
            guard let data = data else {
                completion([], APIError.invalidData)
                return
            }
            
            if let videoResponse = try? JSONDecoder().decode(VideoResponse.self, from: data) {
                completion(videoResponse.results, nil)
                return
            } else {
                completion([], APIError.invalidResponse)
            }
        }
        dataTask.resume()
    }

    func getCredits(for movie: Movie, with type: ContentType, completion: @escaping MovieAPIClientProtocol.MovieCreditsCompletionHandler) {
        guard let creditsURL = URL(string: APIEndPoints.movieCredits(movie: movie).buildUrl(for: type)) else { return }
        
//        guard let creditsURL = URL(string: "https://api.themoviedb.org/3/movie/475557/credits?api_key=381b8c0be715e4249021621d8c95ed62") else { return }
        
        let request = URLRequest(url: creditsURL)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion([], error)
                return
            }
            
            guard let data = data else {
                completion([], APIError.invalidData)
                return
            }
            
            if let creditsResponse = try? JSONDecoder().decode(CastResponse.self, from: data) {
                completion(creditsResponse.cast, nil)
                return
            } else {
                completion([], APIError.invalidResponse)
            }
        }
        dataTask.resume()
    }
}






