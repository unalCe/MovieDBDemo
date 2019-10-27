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
    
    init(movies: [Movie], content: ContentType, listType: ListType, didSelectItemHandler: @escaping MovieSelectHandler) {
        self.movies = movies
        self.content = content
        self.listType = listType
        self.didSelectItemHandler = didSelectItemHandler
    }
}

extension MovieDataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch listType {
        case .TopRated:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listType.rawValue, for: indexPath) as! TopRatedCollectionViewCell
            cell.movie = movies[indexPath.row]
            return cell
        case .NowPlaying:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listType.rawValue, for: indexPath) as! NowPlayingCollectionViewCell
            cell.movie = movies[indexPath.row]
            return cell
        case .Popular:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listType.rawValue, for: indexPath) as! PopularCollectionViewCell
            cell.movie = movies[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        didSelectItemHandler?(movie)
    }
}

extension MovieDataSource: UICollectionViewDelegateFlowLayout {
    
    private func calculateCellSize(for contentType: ContentType, list: ListType, in collectionView: UICollectionView) -> CGSize {
        switch listType {
        case .TopRated:
            return CGSize(width: collectionView.bounds.width * 0.865, height: collectionView.bounds.height - CollectionViewProperties.VerticalInsets)
        case .NowPlaying:
            return CGSize(width: collectionView.bounds.width * 0.42, height: collectionView.bounds.height - CollectionViewProperties.VerticalInsets)
        case .Popular:
            let width = (collectionView.bounds.width - (CollectionViewProperties.HorizontalInsets + ((CollectionViewProperties.NumberOfColumnsInGrid - 1) * CollectionViewProperties.HorizontalSpaceBetweenItems))) / CollectionViewProperties.NumberOfColumnsInGrid
            return CGSize(width: width, height: width * CollectionViewProperties.PosterImageRatio)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateCellSize(for: .Movie, list: listType, in: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewProperties.HorizontalSpaceBetweenItems
    }
}

