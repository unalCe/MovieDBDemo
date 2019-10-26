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
    
    let topRatedDataSource = MovieDataSource(content: .Movie, listType: .TopRated)
    let popularDataSource = MovieDataSource(content: .Movie, listType: .Popular)
    let nowPlayingDataSource = MovieDataSource(content: .Movie, listType: .NowPlaying)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup(collectionView: topRatedCollectionView, dataSource: topRatedDataSource)
        setup(collectionView: nowPlayingCollectionView, dataSource: nowPlayingDataSource)
        setup(collectionView: popularCollectionView, dataSource: popularDataSource)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        popularCollectionViewHeightConstraint.constant = popularCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    private func setup(collectionView: UICollectionView, dataSource: MovieDataSource) {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.layer.masksToBounds = false
    }
}
