//
//  Artist.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 29.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

struct Artist: Codable {
    var character: String
    var name: String
    var profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case profilePath = "profile_path", character, name
    }
}
