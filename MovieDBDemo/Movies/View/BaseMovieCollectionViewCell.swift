//
//  BaseMovieCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 27.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class BaseMovieCollectionViewCell: UICollectionViewCell {
    
    var movie: Movie?
    var backImage: UIImage?
    
    func configure(with viewModel: BaseMovieCellViewModel, for listType: ListType) {
        self.movie = viewModel.getMovie()
        
        // TopRated cells are in landscape, bring wide background images.
        let imageURL = (listType == .TopRated) ? movie!.getBackDropURL() : movie!.getPosterUrl()
        
        viewModel.getImage(with: imageURL, completion: { (img) in
            self.backImage = img
            self.layoutSubviews()
        })
    }
}
