//
//  MovieDetail.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 27.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

struct MovieDetail {
    var movieId: Int
    var title: String
    var overview: String
    var posterPath: String
    
    var genres: [[String: Any]]
    var voteAverage: Double
    var cast: [[String: Any]]
}
