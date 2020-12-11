//
//  TrailerMovie.swift
//  MovieList
//
//  Created by Elattar on 3/13/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
import Alamofire

class ApiManagerTralier{
    
    static func video(_ id: Int,completion: @escaping (_ error: String?, _ movie: Video?) -> ())  {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=71f0fa29711ad6901183195ce61fdfba&language=en-US"
        
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
                    let movie = try JSONDecoder().decode(Video.self, from: data)
                    completion(nil,movie)
                }catch{
                    print("Error trying to decode response Gen")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
                
                
            }
            
        }
    }
    
}
