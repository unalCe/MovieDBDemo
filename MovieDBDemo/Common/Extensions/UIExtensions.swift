//
//  UIExtensions.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit


extension UICollectionViewCell {
    
    func setupDefaultCellLook() {
        self.layer.cornerRadius = 8
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.3
        self.layer.masksToBounds = false
    }
}
