//
//  NowPlayingCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: BaseMovieCollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = movie?.title.uppercased()
        
        titleLabel.addShadow(forText: true)
        shadowView.addShadow()
        
        posterImageView.image = backImage
        posterImageView.layer.cornerRadius = CellProperties.cornerRadius
    }
}
