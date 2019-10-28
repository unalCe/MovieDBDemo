//
//  PopularCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 25.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class PopularCollectionViewCell: BaseMovieCollectionViewCell {

    @IBOutlet weak var backImageView: UIImageView!
    
    let voteView = UIView()
    let voteLabel = UILabel()
    
    var voteGradient: CAGradientLayer!
    
    override func awakeFromNib() {
        setupVoteLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
        
        backImageView.image = backImage
        backImageView.layer.cornerRadius = CellProperties.cornerRadius
        
        updateSubviews()
        updateVotes()
    }
    
    private func setupVoteLabel() {
        voteGradient = CAGradientLayer()
        let startColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0, alpha: 1).cgColor; let endColor = #colorLiteral(red: 0.8588235294, green: 0.1882352941, blue: 0.4117647059, alpha: 1).cgColor
        voteGradient.colors = [startColor, endColor]
        voteGradient.startPoint = CGPoint(x: 0, y: 0)
        voteGradient.endPoint = CGPoint(x: 1, y: 1)
        
        voteView.layer.insertSublayer(voteGradient, at: 0)
        voteView.clipsToBounds = true
        
        addSubview(voteView)
        voteView.addSubview(voteLabel)
        
        voteView.translatesAutoresizingMaskIntoConstraints = false
        voteLabel.translatesAutoresizingMaskIntoConstraints = false

        voteLabel.textAlignment = .center
    }
    
    private func updateSubviews() {
        
        NSLayoutConstraint.activate([
            voteView.topAnchor.constraint(equalTo: backImageView.topAnchor, constant: 12),
            voteView.rightAnchor.constraint(equalTo: backImageView.rightAnchor, constant: -12),
            voteView.widthAnchor.constraint(equalToConstant: 37),
            voteView.heightAnchor.constraint(equalTo: voteView.widthAnchor),
            
            voteLabel.topAnchor.constraint(equalTo: voteView.topAnchor),
            voteLabel.bottomAnchor.constraint(equalTo: voteView.bottomAnchor),
            voteLabel.leftAnchor.constraint(equalTo: voteView.leftAnchor),
            voteLabel.rightAnchor.constraint(equalTo: voteView.rightAnchor)
            ])
        
        voteView.layer.cornerRadius = voteView.bounds.width / 2
        voteGradient.frame = voteView.bounds
    }
    
    private func updateVotes() {
        
        let bigAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let smallAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white]
        
        if let movie = movie {
            let digits = String(movie.voteAverage).components(separatedBy: ".")
            
            let voteText = NSMutableAttributedString(string: "\(digits[0]).", attributes: bigAttribute)
            let smallText = NSMutableAttributedString(string: "\(digits[1])", attributes: smallAttribute)
            voteText.append(smallText)
            
            voteLabel.attributedText = voteText
        }
    }
}
