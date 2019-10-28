//
//  UIExtensions.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit


extension UIView {
    
    func addShadow(forText: Bool = false) {
        self.layer.cornerRadius = CellProperties.cornerRadius
        if !forText {
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: CellProperties.cornerRadius).cgPath
        }
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CellProperties.shadowOffset
        self.layer.shadowRadius = CellProperties.shadowRadius
        self.layer.shadowOpacity = CellProperties.shadowOpacity
        self.layer.masksToBounds = false
    }
}
