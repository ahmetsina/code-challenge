//
//  SecondViewController.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 30.06.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController {
 
  let networkManager = NetworkManager()
  var top_rated_shows = [Show]()
  var popular_shows = [Show]()
  let baseImageURL = "http://image.tmdb.org/t/p/w1280"
  @IBOutlet weak var topRatedCV: UICollectionView!
  @IBOutlet weak var popularCV: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    topRatedCV.delegate = self
    topRatedCV.dataSource = self
    topRatedCV.register(UINib(nibName: "NowPlayingCVCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingCVCell")
    popularCV.register(UINib(nibName: "PopularShowsCVCell", bundle: nil), forCellWithReuseIdentifier: "PopularCVCell")
    
   
    
    networkManager.getPopularShows(page: 1) { shows, error in
      if let error = error {
        print(error)
      }
      if let shows = shows {
        self.popular_shows = shows
        DispatchQueue.main.async {
          self.popularCV.reloadData()
        }
      }
      
    }
    networkManager.getTopRatedShows(page: 1) { shows, error in
      if let error = error {
        print(error)
      }
      if let shows = shows {
        self.top_rated_shows = shows
        DispatchQueue.main.async {
          self.topRatedCV.reloadData()
        }
      }
      
    }
  }

}



extension ShowsViewController : UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.popularCV {
      return self.popular_shows.count
    }else {
      return self.top_rated_shows.count
    }
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == self.topRatedCV {
      let cell = topRatedCV.dequeueReusableCell(withReuseIdentifier: "NowPlayingCVCell", for: indexPath) as! NowPlayingCVCell
      let movie = self.top_rated_shows[indexPath.row]
      let url = URL(string: self.baseImageURL + movie.posterPath)
      DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.async {
          cell.backgroundImage.image = UIImage(data: data!)
        }
      }
      cell.nameLabel.text = movie.name.uppercased()
      
      return cell
    }
    else {
      let cell = popularCV.dequeueReusableCell(withReuseIdentifier: "PopularCVCell", for: indexPath) as! PopularShowsCVCell
      let movie = self.popular_shows[indexPath.row]
      let url = URL(string: self.baseImageURL + movie.backdropPath)
      DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.async {
          cell.posterImage.image = UIImage(data: data!)
        }
      }
      
      cell.nameLabel.text = "\(movie.name.uppercased()) (\(movie.firstAirDate.substring(4))- )"
      //cell.yearLabel.text = movie.lastAirDate
      
      cell.ratingLabel.text = "\(movie.voteAverage.toString())".substring(1)
      cell.ratingDecimalLabel.text = ".\(movie.voteAverage.toString())".upstring(2)
      return cell
    }
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == topRatedCV {
      guard let cell = collectionView.cellForItem(at: indexPath) else {return}
      performSegue(withIdentifier: "topRatedShowSegueID", sender: cell)
    }
    if collectionView == popularCV {
      guard let cell = collectionView.cellForItem(at: indexPath) else {return}
      performSegue(withIdentifier: "popularShowSegueID", sender: cell)
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "topRatedShowSegueID" {
      guard let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() else {return}
      guard let detailViewController = segue.destination as? DetailViewController else {return}
      
      detailViewController.movieID = self.top_rated_shows[indexPath.row].id
      detailViewController.isShow = true
      
    }
    if segue.identifier == "popularShowSegueID" {
      guard let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() else {return}
      guard let detailViewController = segue.destination as? DetailViewController else {return}
      
      detailViewController.movieID = self.popular_shows[indexPath.row].id
      detailViewController.isShow = true
      
    }
    
  }
  
}
