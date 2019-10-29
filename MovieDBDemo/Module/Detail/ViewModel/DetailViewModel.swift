//
//  DetailViewModel.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 29.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation


class DetailViewModel {
    
    var apiClient: MovieAPIClientProtocol!
    var currentMovie: Movie!
    var contentType: ContentType!
    
    init(movie: Movie, contentType: ContentType) {
        self.apiClient = MovieAPIClient()
        self.currentMovie = movie
        self.contentType = contentType
    }
    
    func getDetails(completion: @escaping (MovieDetail) -> Void ) {
        apiClient.getDetails(for: currentMovie, with: contentType) { (movieDetail, error) in
            if movieDetail != nil {
                completion(movieDetail!)
            }
        }
    }
    
    func getVideo(completion: @escaping () -> Void) {
        
    }
}
