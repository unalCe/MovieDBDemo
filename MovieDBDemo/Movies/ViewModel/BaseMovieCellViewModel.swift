//
//  BaseMovieCellViewModel.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 28.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class BaseMovieCellViewModel {
    
    private var apiClient: MovieAPIClientProtocol
    private var currentMovie: Movie
    
    init(movie: Movie) {
        self.apiClient = MovieAPIClient()
        self.currentMovie = movie
    }
    
    /// Getting images repeadetly causes a little lag on simulator. Try Kingfisher which supports caching.
    func getImage(with url: String, completion: @escaping (UIImage) -> Void ) {
        guard let imageURL = URL(string: url) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() {
                completion(image)
            }
        }
        dataTask.resume()
    }
    
    func getMovie() -> Movie {
        return currentMovie
    }
}
