//
//  TopRatedCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class TopRatedCollectionViewCell: BaseMovieCollectionViewCell {
    
    @IBOutlet weak var backImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addShadow()
        
        backImageView.image = backImage
        backImageView.layer.cornerRadius = CellProperties.cornerRadius
    }
}
