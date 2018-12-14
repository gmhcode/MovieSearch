//
//  Movie.swift
//  MovieSearch
//
//  Created by Greg Hughes on 12/14/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation
import UIKit


struct TopLevelDictionary: Codable {
    
    let results : [Movies]?
    
    
}

 struct Movies: Codable {
    
    let title : String
    let rating: Double
    let overview: String
    let posterImage: String?
    
    
    enum CodingKeys: String, CodingKey {
        case overview
        case title
        case rating = "vote_average"
        case posterImage = "poster_path"
    }
}

