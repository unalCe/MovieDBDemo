//
//  TVPopularCollectionViewCell.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 29.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import UIKit

class TVPopularCollectionViewCell: BaseMovieCollectionViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteView: UIView!
    @IBOutlet weak var voteLabel: UILabel!
    
    var voteGradient: CAGradientLayer!
    
    override func awakeFromNib() {
        setupVoteGradient()
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.text = movie?.title.uppercased()
        
        titleLabel.addShadow(forText: true)
        shadowView.addShadow()
        
        backImageView.image = backImage
        backImageView.layer.cornerRadius = CellProperties.cornerRadius
        
        voteView.layer.cornerRadius = voteView.bounds.width / 2
        voteGradient.frame = voteView.bounds
        
        updateVotes()
    }
    
    private func setupVoteGradient() {
        voteGradient = CAGradientLayer()
        let startColor = #colorLiteral(red: 0.9764705882, green: 0.6235294118, blue: 0, alpha: 1).cgColor; let endColor = #colorLiteral(red: 0.8588235294, green: 0.1882352941, blue: 0.4117647059, alpha: 1).cgColor
        voteGradient.colors = [startColor, endColor]
        voteGradient.startPoint = CGPoint(x: 0, y: 0)
        voteGradient.endPoint = CGPoint(x: 1, y: 1)
        
        voteView.layer.insertSublayer(voteGradient, at: 0)
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
