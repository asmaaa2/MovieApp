//
//  ConstantsUrls.swift
//  MovieList
//
//  Created by Elattar on 3/10/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//  Key App DataBase:- 71f0fa29711ad6901183195ce61fdfba

import Foundation


let base = "https://api.themoviedb.org/3/movie/"

struct MovieUrl {
    static let popularMovie = "\(base)popular?api_key=71f0fa29711ad6901183195ce61fdfba&language=en-US"
    static let topRatedMovies = "\(base)top_rated?api_key=71f0fa29711ad6901183195ce61fdfba&language=en-US&page=1"
    
}
