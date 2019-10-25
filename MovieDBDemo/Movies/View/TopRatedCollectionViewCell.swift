//
//  TopRatedCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class TopRatedCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        backgroundColor = .blue
        
    }
    
    override func layoutSubviews() {
        setupDefaultCellLook()
    }
}
