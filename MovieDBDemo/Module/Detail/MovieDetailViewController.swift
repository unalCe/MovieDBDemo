//
//  ViewController.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit
import WebKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var webBackImageView: UIImageView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleGradientView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var movieShadowView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var titleGradient: CAGradientLayer!
    
    private var castDataSourceDelegate: CastDataSourceDelegate?
    private var detailViewModel: DetailViewModel!
    
    func setViewModel(viewModel: DetailViewModel) {
        detailViewModel = viewModel
    }
    
    // MARK: - View Life Cycle
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.barStyle = .black
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.navigationBar.barStyle = .default
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader()
        setupMovieImage()
        setupTitleGradient()
        
        getGenres()
        getVideos()
        getImage()
        getCredits()
        
        detailViewModel.configureLabels(titleLabel: titleLabel, voteLabel: voteLabel, overviewLabel: overviewLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleGradient.frame = titleGradientView.bounds
    }
    
    // MARK: - Setup
    private func setupHeader() {
        scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        navigationItem.largeTitleDisplayMode = .never
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.tintColor = .white
    }
    
    private func setupMovieImage() {
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = CellProperties.cornerRadius
    }
    
    private func setupTitleGradient() {        
        titleGradient = CAGradientLayer()
        titleGradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.75).cgColor, UIColor.black.cgColor]
        titleGradient.locations = [0.0, 0.5, 1.0]
        titleGradientView.layer.insertSublayer(titleGradient, at: 0)
    }
    
    private func updateCastCollectionView() {
        castDataSourceDelegate = detailViewModel.getDataSource()
        castCollectionView.dataSource = castDataSourceDelegate
        castCollectionView.delegate = castDataSourceDelegate
        castCollectionView.reloadData()
    }
    
    // MARK: - Fetch data from ViewModel
    private func getImage() {
        detailViewModel.getImage(landscape: false) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
                self.movieShadowView.addShadow()
            }
        }
    }
    
    private func getGenres() {
        detailViewModel.getGenres { (detail) in
            DispatchQueue.main.async {
                self.genreLabel.text = ""
                detail.genres.forEach { self.genreLabel.text?.append($0.name + "   ") }
            }
        }
    }
    
    private func getVideos() {
        detailViewModel.getVideos { (videos) in
            DispatchQueue.main.async {
                if videos.isEmpty {
                    self.webView.isHidden = true
                    self.detailViewModel.getImage(landscape: true, completion: { (image) in
                        self.webBackImageView.image = image
                    })
                } else {
                    self.webBackImageView.isHidden = true
                    self.webView.load(URLRequest(url: (videos.first?.getVideoURL())!))
                }
            }
        }
    }
    
    private func getCredits() {
        detailViewModel.getCredits { [weak self] in
            DispatchQueue.main.async {
                self?.updateCastCollectionView()
            }
        }
    }
}
