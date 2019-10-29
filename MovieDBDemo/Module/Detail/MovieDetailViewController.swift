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
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    let denemeVideoKey = "t433PEQGErc"
    
    private var detailViewModel: DetailViewModel!
    
    func setViewModel(viewModel: DetailViewModel) {
        detailViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        let urlRequest = URLRequest(url: URL(string: "https://www.youtube.com/embed/t433PEQGErc")!)
        webView.load(urlRequest)
        
        getDetails()
    }
    
    private func getDetails() {
        detailViewModel.getDetails { (detail) in
            DispatchQueue.main.async {
                self.genreLabel.text = detail.genres.first?.name
            }
        }
    }
}

