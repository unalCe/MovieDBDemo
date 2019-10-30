//
//  CastCollectionCellViewModel.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 30.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class CastCollectionCellViewModel {
    
    private(set) var artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
    }
    
    func getArtistImage(completion: @escaping (UIImage) -> Void ) {
        guard let imagePath = artist.profilePath else { return }
        
        guard let imageURL = URL(string: "\(MovieDBBaseAPI.BaseImagePath)\(imagePath)") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() {
                completion(image)
            }
        }
        dataTask.resume()
    }
}
