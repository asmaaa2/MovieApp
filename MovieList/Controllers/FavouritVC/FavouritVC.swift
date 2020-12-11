//
//  FavouritVC.swift
//  MovieList
//
//  Created by Elattar on 3/13/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import UIKit
import CoreData

class FavouritVC: UIViewController {

    @IBOutlet weak var movieTitle_lbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    var film: [PopMovies] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        
        loadMovie()
    }
    

    @objc func refresh(sender:AnyObject) {
       // Code to refresh table view
        loadMovie()
    }
    
    func loadMovie()  {
        let fetchRequest: NSFetchRequest<PopMovies> = PopMovies.fetchRequest()
        
        do{
            film = try context.fetch(fetchRequest)
            tableView.reloadData()
            refreshControl.endRefreshing()
        }catch{
            print("Error , Sorry I can not fetch data from local storge")
        }
    }
 

}
//MARK:- UITableView Delegate and Data Source
extension FavouritVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return film.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoCell", for: indexPath) as! FavoCell
        
        if let posterMovie = film[indexPath.row].poster{
            cell.poster_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(posterMovie)"), placeholderImage: UIImage(named: "placeholder"))
        }else{
            print("No Poster")
        }
        
        cell.movieTitle_lbl.text = film[indexPath.row].title
        let movieRate = film[indexPath.row].rate
        cell.rateView.rating = movieRate / 2
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        
        favDetails.movImage = film[indexPath.row].poster
        favDetails.movTitle = film[indexPath.row].title
        favDetails.movRating = film[indexPath.row].rate
        favDetails.movYear = film[indexPath.row].date
        favDetails.movDetails = film[indexPath.row].details
        favDetails.flag = 2
        self.navigationController?.pushViewController(favDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let movie = film[indexPath.row]
            context.delete(movie)
            film.remove(at: indexPath.row)
            appDelegate.saveContext()
            tableView.reloadData()
        }
    }
    
}
