//
//  MoviesViewController.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    @IBOutlet weak var topRatedCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    @IBOutlet weak var popularCollectionViewHeightConstraint: NSLayoutConstraint!
    
    // private var topRatedDataSource: MovieDataSource?
    
    private let topRatedViewModel = MoviesViewModel(contentType: .Movie, listType: .TopRated)
    private let popularViewModel = MoviesViewModel(contentType: .Movie, listType: .Popular)
    private let nowPlayingViewModel = MoviesViewModel(contentType: .Movie, listType: .NowPlaying)
    
    private var topRatedDataSource: MovieDataSourceDelegate?
    private var popularDataSource: MovieDataSourceDelegate?
    private var nowPlayingDataSource: MovieDataSourceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovies(for: topRatedCollectionView, with: topRatedViewModel)
        getMovies(for: popularCollectionView, with: popularViewModel)
        getMovies(for: nowPlayingCollectionView, with: nowPlayingViewModel)
    }
    
    private func reload(collectionView: UICollectionView, with viewModel: MoviesViewModel) {
        // dataSource = nowPlayingViewModel.getDataSource(didSelectItemHandler: didSelectMovie())
        
        switch viewModel.listType {
        case .TopRated:
            topRatedDataSource = viewModel.getDataSource(didSelectItemHandler: didSelectMovie())
            collectionView.dataSource = topRatedDataSource
            collectionView.delegate = topRatedDataSource
        case .NowPlaying:
            nowPlayingDataSource = viewModel.getDataSource(didSelectItemHandler: didSelectMovie())
            collectionView.dataSource = nowPlayingDataSource
            collectionView.delegate = nowPlayingDataSource
        case .Popular:
            popularDataSource = viewModel.getDataSource(didSelectItemHandler: didSelectMovie())
            collectionView.dataSource = popularDataSource
            collectionView.delegate = popularDataSource
            
            popularCollectionViewHeightConstraint.constant = popularCollectionView.collectionViewLayout.collectionViewContentSize.height
        }
        collectionView.layer.masksToBounds = false
        collectionView.reloadData()
    }
    
    private func getMovies(for collectionView: UICollectionView, with viewModel: MoviesViewModel) {
        viewModel.getMovies { [weak self] in
            DispatchQueue.main.async {
                self?.reload(collectionView: collectionView, with: viewModel)
            }
        }
    }
    
    private func didSelectMovie() -> MovieDataSourceDelegate.MovieSelectHandler {
        return { [weak self] (movie, content) in
            if let strongSelf = self {
                let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController") as! MovieDetailViewController
                
                let detailViewModel = DetailViewModel(movie: movie, contentType: content)
                destinationVC.setViewModel(viewModel: detailViewModel)
                
                strongSelf.navigationController?.pushViewController(destinationVC, animated: true)
            }
        }
    }
}
