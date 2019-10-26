//
//  CellSize.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 26.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

struct CellProperties {
    static let cornerRadius: CGFloat = 8
    static let shadowRadius: CGFloat = 6
    static let shadowOpacity: Float = 0.3
    static let shadowOffset = CGSize(width: 0, height: 5)
}

struct CollectionViewProperties {
    static let NumberOfColumnsInGrid: CGFloat = 2
    static let PosterImageRatio: CGFloat = 3.0/2.0
    static let HorizontalInsets: CGFloat = 20 + 20
    static let VerticalInsets: CGFloat = 8 + 8
    static let HorizontalSpaceBetweenItems: CGFloat = 12
    static let VerticalSpaceBetweenItems: CGFloat = 12
}
