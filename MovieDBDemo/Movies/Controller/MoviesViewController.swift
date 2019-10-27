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
    
  //  let topRatedDataSource = MovieDataSource(content: .Movie, listType: .TopRated)
    //let popularDataSource = MovieDataSource(content: .Movie, listType: .Popular)
//    let nowPlayingDataSource = MovieDataSource(content: .Movie, listType: .NowPlaying)
    
    // private var topRatedDataSource: MovieDataSource?
    
    //var topRatedViewModel = MoviesViewModel(contentType: .Movie, listType: .TopRated)
    //var popularViewModel = MoviesViewModel(contentType: .Movie, listType: .Popular)
    let nowPlayingViewModel = MoviesViewModel(contentType: .Movie, listType: .NowPlaying)
    
    var dataSource: MovieDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        setup(collectionView: topRatedCollectionView, viewModel: topRatedViewModel)
//        setup(collectionView: nowPlayingCollectionView, viewModel: nowPlayingViewModel)
//        setup(collectionView: popularCollectionView, viewModel: popularViewModel)
        
  //      getMovies(for: topRatedCollectionView, with: topRatedViewModel)
  //      getMovies(for: nowPlayingCollectionView, with: nowPlayingViewModel)
  //      getMovies(for: popularCollectionView, with: popularViewModel)
        
        getMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        popularCollectionViewHeightConstraint.constant = popularCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
//    private func setup(collectionView: UICollectionView, viewModel: MoviesViewModel) {
//        let dataSource = viewModel.getDataSource(didSelectItemHandler: didSelectMovie())
//        collectionView.dataSource = dataSource
//        collectionView.delegate = dataSource
//        collectionView.layer.masksToBounds = false
//        collectionView.reloadData()
//    }
    
    func reloadData() {
        dataSource = nowPlayingViewModel.getDataSource(didSelectItemHandler: didSelectMovie())
        
        nowPlayingCollectionView.dataSource = dataSource
        nowPlayingCollectionView.delegate = dataSource
        nowPlayingCollectionView.reloadData()
    }
    
    private func getMovies() {
        nowPlayingViewModel.getMovies { [weak self] in
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }
    }
    
//    private func getMovies(for collectionView: UICollectionView, with viewModel: MoviesViewModel) {
//        viewModel.getMovies { [weak self] in
//            DispatchQueue.main.async {
//                self?.setup(collectionView: collectionView, viewModel: viewModel)
//            }
//        }
//    }
    
    private func didSelectMovie() -> MovieDataSource.MovieSelectHandler {
        return { [weak self] (movie) in
            if let strongSelf = self {
         //       strongSelf.delegate.showDetails(of: movie, from: strongSelf)
                let vc = MovieDetailViewController()
                vc.movie = movie
                strongSelf.show(vc, sender: nil)
            }
        }
    }
}
