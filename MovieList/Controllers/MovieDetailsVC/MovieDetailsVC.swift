//
//  MovieDetailsVC.swift
//  MovieList
//
//  Created by Elattar on 3/13/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos
import YouTubePlayer
import CoreData

class MovieDetailsVC: UIViewController {
    
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: CosmosView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieDetails: UITextView!
    @IBOutlet weak var movieTrailer: YouTubePlayerView!
    @IBOutlet weak var reviewTableX: UITableView!
    @IBOutlet weak var noVideo: UIView!
    
    var trailer: [VideoDetails] = []
    var reviews: [Result] = []
    
    var ids: [Int] = []
    
    var flag: Int = 0
    
    var videoMovie = String ()
    var movImage: String?
    var movBackground: String?
    var movTitle: String?
    var movRating: Double?
    var movYear: String?
    var movCount: Int?
    var movDetails: String?
    var movId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    private func setupView(){
        
       movieRating.settings.updateOnTouch = false
        
//        movieImg.layer.cornerRadius = movieImg.frame.size.height / 2
//        movieImg.clipsToBounds = true

        if let posterUrl = movImage{
            movieImg.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(posterUrl)"), placeholderImage: UIImage(named: "placeholder"))
        }else{
            movieImg.image = UIImage(named: "placeholder")
        }
        
//        if let backDropUrl = movBackground{
//            background_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(backDropUrl)"), placeholderImage: UIImage(named: "placeholder"))
//        }else{
//            movieImg.image = UIImage(named: "placeholder")
//        }
        
        movieTitle.text = movTitle
        movieYear.text = movYear
        movieDetails.text = movDetails
        movieRating.rating =  (movRating ?? 1) / 2
        
        fetchTrailer(idMovie: movId ?? 0)
        fetchReviews(id: movId ?? 0)
        
        
        if flag == 1 {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "favourit"), style: .plain, target: self, action: #selector(favo_btn))
            noVideo.isHidden = true
            movieTrailer.isHidden = false
            reviewTableX.isHidden = false
        }else if flag == 2{
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "correct"), style: .plain, target: self, action: #selector(favo_btn))
            self.noVideo.isHidden = false
            movieTrailer.isHidden = true
            reviewTableX.isHidden = true

        }
        
    }
    
    @objc func favo_btn(){
        
        if flag == 1{
            ids.append(movId ?? 1)
            let movie = PopMovies(context: context)
            movie.title = movTitle
            movie.details = movDetails
            movie.poster = movImage
            movie.rate = movRating ?? 0.0
            movie.date = movYear
            
            do{
                appDelegate.saveContext()
                print("Save")
            }catch{
                print("Problem in Save")
            }
        }else if flag == 2 {

        }
        
        
    }
    
    func fetchTrailer(idMovie: Int)  {
        ApiManagerTralier.video(idMovie){ (error, movie) in
            if let error = error{
           //     self.showAlert(title: "Sorry", massage: error)
            }else if let film = movie{
                self.trailer = film.results
                if self.flag == 1{
                    for i in self.trailer{
                        if let myVideoURL = URL(string: "https://www.youtube.com/watch?v=\(i.key)"){
                            self.movieTrailer.loadVideoURL(myVideoURL)
                            self.videoMovie = "https://www.youtube.com/watch?v=\(i.key)"
                        }else{
                            print("error")
                            return
                        }
                    }
                }else if self.flag == 2{
                    self.movieTrailer.backgroundColor = .red
                }
    
            }
        }
    }
    
    func fetchReviews(id: Int){
        ApiManagerReviews.review(id) { (error, review) in
            if let error = error{
               // self.showAlert(title: "Sorry", massage: error)
            }else if let filmRreview = review{
                self.reviews = filmRreview.results
                self.reviewTableX.reloadData()
            }
        }
    }
    
}

//MARK:- UITableView Delegeta and Data Soruce
extension MovieDetailsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        cell.name_lbl.text = reviews[indexPath.row].author
        cell.contant_tv.text = reviews[indexPath.row].content
        return cell
    }
        
}
