//
//  MovieDataSource.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

enum ContentType {
    case Movie
    case TVShow
}

enum ListType: String {
    case TopRated = "topRatedCell"
    case NowPlaying = "nowPlayingCell"
    case Popular = "popularCell"
}

class MovieDataSource: NSObject {
    typealias MovieSelectHandler = (Movie) -> ()
    
    var movies: [Movie] = []
    var didSelectItemHandler: MovieSelectHandler?
    
    var content: ContentType
    var listType: ListType
    
    init(content: ContentType, listType: ListType) {
        self.content = content
        self.listType = listType
    }
}

extension MovieDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      //  var cell = collectionView.dequeueReusableCell(withReuseIdentifier: listType.rawValue, for: indexPath)
         let cell = getCustomCellClass(for: collectionView, reuseIdentifier: listType.rawValue, indexPath: indexPath)
        
        // cell.viewModel --> configure
        
        return cell
    }
    
    private func getCustomCellClass(for collectionView: UICollectionView, reuseIdentifier: String, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        switch listType {
        case .TopRated: return cell as! TopRatedCollectionViewCell
        case .NowPlaying: return cell as! NowPlayingCollectionViewCell
        case .Popular: return cell as! PopularCollectionViewCell
        }
    }
}

extension MovieDataSource: UICollectionViewDelegateFlowLayout {
    
    private func calculateCellSize(for contentType: ContentType, list: ListType, in collectionView: UICollectionView) -> CGSize {
        
        switch listType {
        case .TopRated:
            return CGSize(width: collectionView.bounds.width * 0.9, height: collectionView.bounds.height - 16)
        case .NowPlaying:
            return CGSize(width: collectionView.bounds.width * 0.42, height: collectionView.bounds.height - 16)
        case .Popular:
            // Left and right content insets are both 20 - 20  & 12 cell spacing => 52
            let width = (collectionView.bounds.width - 52) / 2
            return CGSize(width: width, height: width * 3 / 2)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let width = (collectionView.bounds.width / 2) - 40
        //return CGSize(width: width, height: width * 3 / 2)
        
        return calculateCellSize(for: .Movie, list: listType, in: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

