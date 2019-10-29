//
//  TVViewController.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

//TODO: - Bu VC, moviesVC ile neredeyse aynı. base class oluşturup kullan

class TVViewController: UIViewController {

    @IBOutlet weak var tvTopCollectionView: UICollectionView!
    @IBOutlet weak var tvPopularCollectionView: UICollectionView!
    @IBOutlet weak var tvPopularHeightConstraint: NSLayoutConstraint!
    
    let tvTopViewModel = MoviesViewModel(contentType: .TVShow, listType: .TopRated)
    let tvPopularViewModel = MoviesViewModel(contentType: .TVShow, listType: .Popular)
    
    var tvTopDataSource: MovieDataSourceDelegate?
    var tvPopularDataSource: MovieDataSourceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getTVShows(for: tvTopCollectionView, with: tvTopViewModel)
        getTVShows(for: tvPopularCollectionView, with: tvPopularViewModel)
    }
    
    private func reload(collectionView: UICollectionView, with viewModel: MoviesViewModel) {
        // dataSource = nowPlayingViewModel.getDataSource(didSelectItemHandler: didSelectMovie())
        
        switch viewModel.listType {
        case .TopRated:
            tvTopDataSource = viewModel.getDataSource(didSelectItemHandler: didSelectMovie())
            collectionView.dataSource = tvTopDataSource
            collectionView.delegate = tvTopDataSource
        case .Popular:
            tvPopularDataSource = viewModel.getDataSource(didSelectItemHandler: didSelectMovie())
            collectionView.dataSource = tvPopularDataSource
            collectionView.delegate = tvPopularDataSource
            
            tvPopularHeightConstraint.constant = tvPopularCollectionView.collectionViewLayout.collectionViewContentSize.height
        default:
            fatalError("should not reach here")
        }
        collectionView.layer.masksToBounds = false
        collectionView.reloadData()
    }
    
    private func getTVShows(for collectionView: UICollectionView, with viewModel: MoviesViewModel) {
        viewModel.getMovies { [weak self] in
            DispatchQueue.main.async {
                self?.reload(collectionView: collectionView, with: viewModel)
            }
        }
    }
    
    private func didSelectMovie() -> MovieDataSourceDelegate.MovieSelectHandler {
        return { [weak self] (movie) in
            if let strongSelf = self {
                let vc = MovieDetailViewController()
                vc.movie = movie
                // strongSelf.show(vc, sender: nil)
                //strongSelf.present(vc, animated: true, completion: nil)
                strongSelf.presentDetail(vc)
            }
        }
    }
}

