//
//  CastDataSourceDelegate.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 30.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class CastDataSourceDelegate: NSObject {
    var cast: [Artist] = []
    
    init(cast: [Artist]) {
        self.cast = cast
    }
}

extension CastDataSourceDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as! CastCollectionViewCell
        
        cell.configure(with: CastCollectionCellViewModel(artist: cast[indexPath.row]))
        
        return cell
    }
}

extension CastDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - CollectionViewProperties.HorizontalInsets) * 0.28
        let height = collectionView.bounds.height - CollectionViewProperties.HorizontalInsets
        return CGSize(width: width , height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewProperties.HorizontalSpaceBetweenItems
    }
}
