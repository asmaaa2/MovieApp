//
//  Trailers.swift
//  MovieList
//
//  Created by Elattar on 3/13/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//


import Foundation


struct VideoDetails: Codable {
    var key: String
}

struct Video: Codable {
    var results: [VideoDetails]
    
}


