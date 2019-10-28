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

extension UIViewController {
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false)
    }
}
