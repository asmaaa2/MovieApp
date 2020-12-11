//
//  Review.swift
//  MovieList
//
//  Created by Elattar on 3/17/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
struct MovieReview : Codable {
    let id : Int?
    let page : Int?
    let results : [Result]
    let total_pages : Int?
    let total_results : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case page = "page"
        case results = "results"
        case total_pages = "total_pages"
        case total_results = "total_results"
    }
}

struct Result : Codable {
    let author : String?
    let content : String?
    let id : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case author = "author"
        case content = "content"
        case id = "id"
        case url = "url"
    }


}
