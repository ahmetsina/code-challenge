//
//  FirstViewController.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 30.06.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UICollectionViewDelegateFlowLayout {
  
  let networkManager = NetworkManager()
  var nowplaying_movies = [Movie]()
  var popular_movies = [Movie]()
  let baseImageURL = "http://image.tmdb.org/t/p/w500"
  @IBOutlet weak var nowPlayingCV: UICollectionView!
  @IBOutlet weak var popularCV: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
   
    nowPlayingCV.delegate = self
    nowPlayingCV.dataSource = self
    popularCV.delegate = self
    popularCV.dataSource = self
    nowPlayingCV.register(UINib(nibName: "NowPlayingCVCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingCVCell")
    popularCV.register(UINib(nibName: "PopularCVCell", bundle: nil), forCellWithReuseIdentifier: "PopularCVCell")
    
   
    
    networkManager.getNewMovies(page: 1) { movies, error in
      if let error = error {
        print(error)
      }
      if let movies = movies {
        self.nowplaying_movies = movies
        DispatchQueue.main.async {
          self.nowPlayingCV.reloadData()
        }
      }
      
   
  
  }
    networkManager.getPopularMovies(page: 1) { movies, error in
      if let error = error {
        print(error)
      }
      if let movies = movies {
        self.popular_movies = movies
        DispatchQueue.main.async {
          self.popularCV.reloadData()
        }
      }
      
    }
  }
  private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath
    indexPath: IndexPath) -> CGSize {
    if collectionView == nowPlayingCV {
      return CGSize(width: self.view.frame.width/3, height: 250)
    }
    else {
      return CGSize(width: self.view.frame.width/3, height: 350)
    }
  }


  
}



extension MoviesViewController : UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if collectionView == self.popularCV {
      return self.popular_movies.count
    }else {
      return self.nowplaying_movies.count
    }
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == self.nowPlayingCV {
      let cell = nowPlayingCV.dequeueReusableCell(withReuseIdentifier: "NowPlayingCVCell", for: indexPath) as! NowPlayingCVCell
      let movie = self.nowplaying_movies[indexPath.row]
      let url = URL(string: self.baseImageURL + movie.posterPath)
      DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.async {
          cell.backgroundImage.image = UIImage(data: data!)
        }
      }
      cell.nameLabel.text = movie.title.uppercased()
      return cell
    }
    else {
      let cell = popularCV.dequeueReusableCell(withReuseIdentifier: "PopularCVCell", for: indexPath) as! PopularCVCell
      let movie = self.popular_movies[indexPath.row]
      let url = URL(string: self.baseImageURL + movie.posterPath)
      DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.async {
          cell.backgroundImage.image = UIImage(data: data!)
        }
      }
      cell.nameLabel.text = movie.title.uppercased()
      cell.yearLabel.text = movie.releaseDate.substring(4)
      
      cell.ratingLabel.text = "\(movie.rating.toString())".substring(1)
      cell.ratingDecimalLabel.text = ".\(movie.rating.toString())".upstring(2)
      return cell
    }
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if collectionView == nowPlayingCV {
      guard let cell = collectionView.cellForItem(at: indexPath) else {return}
      performSegue(withIdentifier: "nowPlayingMovieSegueID", sender: cell)
    }
    if collectionView == popularCV {
      guard let cell = collectionView.cellForItem(at: indexPath) else {return}
      performSegue(withIdentifier: "popularMovieSegueID", sender: cell)
      print(self.popular_movies[indexPath.row].id)
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "nowPlayingMovieSegueID" {
      guard let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() else {return}
      guard let detailViewController = segue.destination as? DetailViewController else {return}
      
      detailViewController.movieID = self.nowplaying_movies[indexPath.row].id
      
    }
    if segue.identifier == "popularMovieSegueID" {
      guard let indexPath = (sender as? UIView)?.findCollectionViewIndexPath() else {return}
      guard let detailViewController = segue.destination as? DetailViewController else {return}
      
      detailViewController.movieID = self.popular_movies[indexPath.row].id
      
      
    }
    
  }
}

