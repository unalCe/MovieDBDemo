//
//  PopularCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        backgroundColor = .orange
        
    }
    
    override func layoutSubviews() {
        setupDefaultCellLook()
    }
}
