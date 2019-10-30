//
//  Video.swift
//  MovieDBDemo
//
//  Created by Unal Celik on 30.10.2019.
//  Copyright © 2019 unalCelik. All rights reserved.
//

import Foundation

struct Video: Codable {
    var id: String
    var key: String
    var name: String
    var site: String
    
    func getVideoURL() -> URL {
        return URL(string: "https://www.youtube.com/embed/\(key)")!
    }
}
