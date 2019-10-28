//
//  MoviesViewModel.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 27.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation


class MoviesViewModel {
    
    var apiClient: MovieAPIClientProtocol!
    var movies: [Movie] = []
    
    var contentType: ContentType
    var listType: ListType
    
    init(contentType: ContentType, listType: ListType) {
        self.apiClient = MovieAPIClient()
        self.contentType = contentType
        self.listType = listType
    }
    
    func getDataSource(didSelectItemHandler: @escaping MovieDataSourceDelegate.MovieSelectHandler) -> MovieDataSourceDelegate {
        return MovieDataSourceDelegate(movies: movies, content: contentType, listType: listType, didSelectItemHandler: didSelectItemHandler)
    }
    
    func getMovies(completion: @escaping () -> Void) {
        apiClient.getMovies(for: listType) { [weak self] (movies, error) in
            if error == nil {
                self?.movies = movies
            }
            completion()
        }
    }
    
    func movie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
//    func getMovies(completion: @escaping () -> Void) {
//        apiClient.getNowPlaying { [weak self] (movieList, error) in
//            if error == nil {
//                self?.movies = movieList
//            }
//            completion()
//        }
//    }
    
}
