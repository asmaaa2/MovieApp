//
//  Movie.swift
//  MovieList
//
//  Created by Elattar on 3/11/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation


struct Movies: Codable {
    
    let results : [Results]
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
}

struct Results: Codable {
    let popularity : Double?
    let vote_count : Int?
    let video : Bool?
    let poster_path : String?
    let id : Int?
    let adult : Bool?
    let backdrop_path : String?
    let original_language : String?
    let original_title : String?
    let genre_ids : [Int]?
    let title : String?
    let vote_average : Double?
    let overview : String?
    let release_date : String?
    
    enum CodingKeys: String, CodingKey {
        
        case popularity = "popularity"
        case vote_count = "vote_count"
        case video = "video"
        case poster_path = "poster_path"
        case id = "id"
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case original_language = "original_language"
        case original_title = "original_title"
        case genre_ids = "genre_ids"
        case title = "title"
        case vote_average = "vote_average"
        case overview = "overview"
        case release_date = "release_date"
        
    }
    
}
