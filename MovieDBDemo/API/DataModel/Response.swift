//
//  Response.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 27.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

struct MoviesResponse: Codable {
    var results: [Movie]
}

struct TVShowResponse: Codable {
    var results: [TVShow]
}

