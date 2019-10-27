//
//  ViewController.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie: Movie? { didSet {
        createLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
    }
    
    private func createLabel() {
        let button = UIButton(frame: CGRect(x: 110, y: 650, width: 100, height: 50))
        button.titleLabel?.text = "Dismiss"
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
        let label = UILabel(frame: CGRect(x: view.frame.midX - 70, y: view.frame.midY, width: 250, height: 100))
        label.text = movie?.title
        view.addSubview(label)
        view.addSubview(button)
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}

