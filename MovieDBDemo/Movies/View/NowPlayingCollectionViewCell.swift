//
//  NowPlayingCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        backgroundColor = .red
        
    }
    
    override func layoutSubviews() {
        setupDefaultCellLook()
    }
}
