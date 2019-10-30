//
//  CastCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 30.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        shadowView.addShadow()
        
        artistImageView.layer.cornerRadius = CellProperties.cornerRadius
    }
    
    func configure(with viewModel: CastCollectionCellViewModel) {
        nameLabel.text = viewModel.artist.name
        
        viewModel.getArtistImage { (image) in
            self.artistImageView.image = image
            self.layoutSubviews()
        }
    }
}
