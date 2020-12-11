//
//  ReviewMovie.swift
//  MovieList
//
//  Created by Elattar on 3/17/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
import Alamofire

class ApiManagerReviews{
    
    static func review(_ id: Int,completion: @escaping (_ error: String?, _ movie: MovieReview?) -> ())  {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=71f0fa29711ad6901183195ce61fdfba&language=en-US&page=1"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (respones) in
            
            switch respones.result{
                
            case .failure(let error):
                print("Error alamofire")
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
                
            case .success(_):
                guard let data = respones.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didin't get any data from API",nil)
                    return
                    
                }
                
                do{
                    let movie = try JSONDecoder().decode(MovieReview.self, from: data)
                    completion(nil,movie)
                    for i in movie.results{
                        print("Title: \(i.author)")
                    }
                }catch{
                    print("Error trying to decode response Gen")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
            }
            
        }
    }
    
}
