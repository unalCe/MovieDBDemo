//
//  DetailViewModel.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 29.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class DetailViewModel {
    
    var apiClient: MovieAPIClientProtocol!
    var currentMovie: Movie!
    var contentType: ContentType!
    
    var cast: [Artist] = []
    
    init(movie: Movie, contentType: ContentType) {
        self.apiClient = MovieAPIClient()
        self.currentMovie = movie
        self.contentType = contentType
    }
    
    func getDataSource() -> CastDataSourceDelegate {
        return CastDataSourceDelegate(cast: self.cast)
    }
    
    func getGenres(completion: @escaping (MovieGenres) -> Void ) {
        apiClient.getGenres(for: currentMovie, with: contentType) { (movieDetail, error) in
            if movieDetail != nil {
                completion(movieDetail!)
            }
        }
    }
    
    func getImage(landscape: Bool, completion: @escaping (UIImage) -> Void ) {
        apiClient.getImage(for: currentMovie, landscape: landscape) { (data) in
            if let image = UIImage(data: data) {
                completion(image)
            }
        }
    }
    
    func getVideos(completion: @escaping ([Video]) -> Void) {
        apiClient.getVideos(for: currentMovie, with: contentType) { (videos, error) in
            if error == nil {
                completion(videos)
            }
        }
    }
    
    func getCredits(completion: @escaping () -> Void) {
        apiClient.getCredits(for: currentMovie, with: contentType) { (artists, error) in
            if error == nil {
                self.cast = artists
            }
            completion()
        }
    }
    
    func configureLabels(titleLabel: UILabel, voteLabel: UILabel, overviewLabel: UILabel) {
        titleLabel.text = currentMovie.title.uppercased()
        overviewLabel.text = currentMovie.overview
        
        let digits = String(currentMovie.voteAverage).components(separatedBy: ".")
        
        let bigAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let smallAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white]
        let voteText = NSMutableAttributedString(string: "\(digits[0]).", attributes: bigAttribute)
        let smallText = NSMutableAttributedString(string: "\(digits[1])", attributes: smallAttribute)
        voteText.append(smallText)
        
        voteLabel.attributedText = voteText
        // FIXME: 
        voteLabel.text = "9.5"
    }
}
