//
//  PopularMovie.swift
//  MovieList
//
//  Created by Elattar on 3/10/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import Foundation
import Alamofire

class ApiManagerPopularMovie {
//    //1
    static func popularMovie (completion: @escaping (_ error: String? , _ movie: Movies?) -> ()){
        Alamofire.request(MovieUrl.popularMovie, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in

            switch response.result{
            case .failure(let error):
                print("Error while fetching data: \(error.localizedDescription)")
                completion(error.localizedDescription,nil)
            case .success(_):


                guard let data = response.data else {
                    print("Error whiles fetching data: didn't get any data from API")
                    completion("didn't get any data from API",nil)
                    return
                }
                //parse for Data
                do{
                    let movie = try JSONDecoder().decode(Movies.self, from: data)
                    completion(nil,movie)
                }catch{
                    print("Error trying to decode response")
                    print(error.localizedDescription)
                    completion(error.localizedDescription,nil)
                }
            }

        }
    }
    
    
//    func getData(completionHandler: @escaping (_ error:String?, _ Movies: Movies?)-> Void) {
//
//        let url = ""
//
//        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//            switch response.result {
//            case.failure(let error):
//                print(error.localizedDescription)
//                completionHandler(error.localizedDescription, nil)
//            case.success(_):
//                guard let data = response.data else {
//                    print("Fail to get Data")
//                    completionHandler("Fail to Fetch Data", nil)
//                    return
//                }
//                do{
//                    let yaBaredB7bk = try JSONDecoder().decode(Movies.self, from: data)
//                    completionHandler(nil, yaBaredB7bk)
//
//                }catch{
//                    completionHandler("5las mtz3lsh b7bk :*", nil)
//
//                }
//
//            }
//        }
//    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
