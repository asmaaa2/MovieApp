//
//  TopRatedMovies.swift
//  MovieList
//
//  Created by Elattar on 3/11/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
import Alamofire

class ApiManagerTopRated {
    static func topRated(completion: @escaping (_ error: String?,_ moviesData: Movies?) -> ()){
        Alamofire.request(MovieUrl.topRatedMovies, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result{
            case .failure(let error) :
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
            case .success(_):
                guard let data = response.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didn't get any data from API",nil)
                    return
                }
                do {
                    let movie = try JSONDecoder().decode(Movies.self, from: data)
                    completion(nil, movie)
                } catch  {
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
            }
        }
        
    }
}
