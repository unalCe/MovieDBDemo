//
//  TVTopRatedCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 29.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class TVTopRatedCollectionViewCell: BaseMovieCollectionViewCell {
    
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
