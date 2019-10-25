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
        // navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
        topRatedCollectionView.dataSource = topRatedDataSource
        topRatedCollectionView.delegate = topRatedDataSource
        topRatedCollectionView.layer.masksToBounds = false
        
      //  topRatedCollectionView.delegate = self
      //  topRatedCollectionView.dataSource = self
        
        
        popularCollectionView.dataSource = popularDataSource
        popularCollectionView.delegate = popularDataSource
        popularCollectionView.layer.masksToBounds = false
        
        nowPlayingCollectionView.dataSource = nowPlayingDataSource
        nowPlayingCollectionView.delegate = nowPlayingDataSource
        nowPlayingCollectionView.layer.masksToBounds = false
        
        let scaledHeight = popularCollectionView.collectionViewLayout.collectionViewContentSize.height
        popularCollectionViewHeightConstraint.constant = scaledHeight
        view.setNeedsLayout()
    }
}
