//
//  ViewController.swift
//  MovieList
//
//  Created by Elattar on 3/9/20.
//  Copyright © 2020 Asmaa. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class HomeVC: UIViewController {
    
    @IBOutlet weak var segController: UISegmentedControl!
    @IBOutlet weak var collectV: UICollectionView!
    @IBOutlet weak var collectionViewX: UICollectionView!
    
    var films: [AllMovies] = []
    var topFilms: [TopRated] = []
    var movieData: [Results] = []
    var isTopRated: Bool = false
    let cellScaling: CGFloat = 0.6
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectV.delegate = self
        collectV.dataSource = self
        fetchPopularMovie()
        self.parent?.title = "Movies"
        customLayout() 
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        collectionViewX.addSubview(refreshControl)
        
        
        if  CheckInternet.Connection() == false{
            //loadMovie()
            //showAlert(title: "Sorry", massage: "not connection")
        }else{
            print("found internet")
            //            deleteAllRecords()
            //            deleteAllTopRecords()
        }
        
        
        
    }
    
    @objc func refresh(sender:AnyObject) {
        // Code to refresh table view
        loadTopMovie()
        
    }
    
    
    
    func loadMovie()  {
        let fetchRequest: NSFetchRequest<AllMovies> = AllMovies.fetchRequest()
        
        do{
            films = try context.fetch(fetchRequest)
            collectionViewX.reloadData()
            refreshControl.endRefreshing()
        }catch{
            print("Error , Sorry I can not fetch data from local storge")
        }
    }
    
    func loadTopMovie()  {
        let fetchRequest: NSFetchRequest<TopRated> = TopRated.fetchRequest()
        
        do{
            topFilms = try context.fetch(fetchRequest)
            collectionViewX.reloadData()
            refreshControl.endRefreshing()
        }catch{
            print("Error , Sorry I can not fetch data from local storge")
        }
    }
    
    func deleteAllTopRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "TopRated")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func deleteAllRecords() {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "AllMovies")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func fetchPopularMovie(){
        ApiManagerPopularMovie.popularMovie { (error, movieData) in
            if let error = error{
                self.showAlert(title: "sorry", massage: error)
                
                
            }else if let film = movieData{
                self.movieData = film.results
                self.collectV.reloadData()
                self.deleteAllRecords()
                for i in self.movieData{
                    let movie = AllMovies(context: context)
                    movie.title = i.title
                    movie.detailes = i.overview
                    movie.poster = i.poster_path
                    movie.rate = i.vote_average ?? 0.0
                    movie.date = i.release_date
                    do{
                        appDelegate.saveContext()
                        print("Save All Movies ")
                    }catch{
                        print("Problem in Save")
                    }
                }
            }
        }
    }
    
    func fetchTopRated() {
        ApiManagerTopRated.topRated { (error, topMoviesData) in
            if let error = error{
                self.showAlert(title: "sorry", massage: error)
                
                
            }else if let topMovies = topMoviesData{
                self.movieData = topMovies.results
                self.collectV.reloadData()
                self.deleteAllTopRecords()
                for i in self.movieData{
                    let movie = TopRated(context: context)
                    movie.title = i.title
                    movie.detailes = i.overview
                    movie.poster = i.poster_path
                    movie.rate = i.vote_average ?? 0.0
                    movie.date = i.release_date
                    do{
                        appDelegate.saveContext()
                        print("Save All Top Movies ")
                    }catch{
                        print("Problem in Save")
                    }
                }
            }
        }
    }
    
    func customLayout() {
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = collectionViewX!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionViewX?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
    }
    
    @IBAction func load_btn(_ sender: Any) {
        loadTopMovie()
        print("Film:- \(films.first?.title)")
    }
    
    
    @IBAction func action_btn(_ sender: Any) {
        print(topFilms.count)
    }
    
    @IBAction func delete_action(_ sender: Any) {
        deleteAllRecords()
    }
    
    @IBAction func save_btn(_ sender: Any) {
        for i in movieData{
            let movie = TopRated(context: context)
            movie.title = i.title
            movie.detailes = i.overview
            movie.poster = i.poster_path
            movie.rate =  i.vote_average ?? 0.0
            movie.date = i.release_date
            do{
                appDelegate.saveContext()
                print("Save All Movies")
            }catch{
                print("Problem in Save")
            }
        }
    }
    
    
    @IBAction func segmentControll_btn(_ sender: Any) {
        let segment = segController.selectedSegmentIndex
        switch segment {
        case 0:
            isTopRated = false
            if  CheckInternet.Connection() == false{
                loadMovie()
            }else{
                fetchPopularMovie()
            }
        case 1:
            isTopRated = true
            if  CheckInternet.Connection() == false{
                loadTopMovie()
            }else{
                fetchTopRated()
            }
        default:
            print("Error")
        }
    }
}

//MARK:- CollectionView Delegate and DataSource
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  CheckInternet.Connection() == false{
            return films.count
        }else{
            return movieData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        
        if CheckInternet.Connection() == false {
            
            
            if isTopRated == true{
                // showAlert(title: "hey", massage: "\(films.count)")
                if let posterMovie = topFilms[indexPath.row].poster{
                    cell.posterMovie_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(posterMovie)"), placeholderImage: UIImage(named: "placeholder"))
                }else{
                    print("No Poster")
                }
            }else{
                // showAlert(title: "hey", massage: "\(films.count)")
                if let posterMovie = films[indexPath.row].poster{
                    cell.posterMovie_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(posterMovie)"), placeholderImage: UIImage(named: "placeholder"))
                }else{
                    print("No Poster")
                }
            }
            
        }else{
            
            if let posterMovie = movieData[indexPath.row].poster_path{
                cell.posterMovie_img.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w342/\(posterMovie)"), placeholderImage: UIImage(named: "placeholder"))
            }else{
                print("No Poster")
            }
            
            let movieRate = movieData[indexPath.row].vote_average
            cell.rate_lbl.text = "\((movieRate ?? 7.0))"
            cell.titleMovie_lbl.text = movieData[indexPath.row].title
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if CheckInternet.Connection() == false{
            
        }else{
            let movieDetails = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
            
            movieDetails.movImage = movieData[indexPath.row].poster_path
            movieDetails.movBackground = movieData[indexPath.row].backdrop_path
            movieDetails.movTitle = movieData[indexPath.row].title
            movieDetails.movRating = movieData[indexPath.row].vote_average
            movieDetails.movYear = movieData[indexPath.row].release_date
            movieDetails.movDetails = movieData[indexPath.row].overview
            movieDetails.movId = movieData[indexPath.row].id
            movieDetails.flag = 1
            self.navigationController?.pushViewController(movieDetails, animated: true)
        }
    }

}

//MARK:- CollectionView Layout
extension HomeVC: UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectionViewX?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
    
    
}
