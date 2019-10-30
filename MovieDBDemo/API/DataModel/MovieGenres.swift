//
//  MovieDetail.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 27.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

struct MovieGenres: Codable {
    var id: Int
    var genres: [Genre]
}

struct Genre: Codable {
    var id: Int
    var name: String
}
