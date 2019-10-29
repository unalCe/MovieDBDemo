//
//  MovieDataSourceDelegate.swift
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

enum ListType {
    case TopRated
    case NowPlaying
    case Popular
}

class MovieDataSourceDelegate: NSObject {
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
    
    private func getCellIdentifier(for content: ContentType, with listType: ListType) -> String {
        switch content {
        case .Movie:
            switch listType {
            case .NowPlaying: return "nowPlayingCell"
            case .Popular: return "popularCell"
            case .TopRated: return "topRatedCell"
            }
        case.TVShow:
            switch listType {
            case .Popular: return "tvPopularCell"
            case .TopRated: return "tvTopCell"
            default: fatalError("there is no reusable cell in TVShow VC for this.")
            }
        }
    }
}

extension MovieDataSourceDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: getCellIdentifier(for: content, with: listType), for: indexPath) as! BaseMovieCollectionViewCell
        cell.configure(with: BaseMovieCellViewModel(movie: movies[indexPath.row]), for: content, with: listType)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        didSelectItemHandler?(movie)
    }
}

extension MovieDataSourceDelegate: UICollectionViewDelegateFlowLayout {
    
    private func calculateCellSize(for contentType: ContentType, list: ListType, in collectionView: UICollectionView) -> CGSize {
        switch contentType {
        case .Movie:
            switch listType {
            case .TopRated:
                return CGSize(width: (collectionView.bounds.width - CollectionViewProperties.HorizontalInsets) * 0.95, height: collectionView.bounds.height - CollectionViewProperties.VerticalInsets)
            case .NowPlaying:
                return CGSize(width: (collectionView.bounds.width - CollectionViewProperties.HorizontalInsets) * 0.46, height: collectionView.bounds.height - CollectionViewProperties.VerticalInsets)
            case .Popular:
                let width = (collectionView.bounds.width - (CollectionViewProperties.HorizontalInsets + ((CollectionViewProperties.NumberOfColumnsInGrid - 1) * CollectionViewProperties.HorizontalSpaceBetweenItems))) / CollectionViewProperties.NumberOfColumnsInGrid
                return CGSize(width: width, height: width * CollectionViewProperties.PosterImageRatio)
            }
        case .TVShow:
            switch listType {
            case .TopRated:
                return CGSize(width: (collectionView.bounds.width - CollectionViewProperties.HorizontalInsets) * 0.46, height: collectionView.bounds.height - CollectionViewProperties.VerticalInsets)
            default:
                let width = collectionView.bounds.width - CollectionViewProperties.HorizontalInsets
                return CGSize(width: width, height: width / CollectionViewProperties.PosterImageRatio)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateCellSize(for: content, list: listType, in: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CollectionViewProperties.HorizontalSpaceBetweenItems
    }
}

