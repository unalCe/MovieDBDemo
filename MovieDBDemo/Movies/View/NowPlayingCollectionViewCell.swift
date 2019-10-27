//
//  NowPlayingCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: BaseMovieCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        backgroundColor = .orange
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = movie?.title
    }
    
//    override func layoutSubviews() {
//        setupDefaultCellLook()
//    }
    
//    private func setupCell(with movie: Movie) {
//        print("\(movie.title)")
//    }
}
