//
//  DetailViewController.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 5.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  var networkManager = NetworkManager()
  let baseImageURL = "http://image.tmdb.org/t/p/w1280"
  var movieDetails : MovieDetail!
  var showDetails : ShowDetail!
  var cast = [Cast]()
  var movieID = Int()
  var isShow = false

  @IBOutlet weak var descriptionText: UITextView!
  @IBOutlet weak var castCV: UICollectionView!
  
  @IBOutlet weak var rateStarImage5: UIImageView!
  @IBOutlet weak var rateStarImage4: UIImageView!
  @IBOutlet weak var rateStarImage3: UIImageView!
  @IBOutlet weak var rateStarImage2: UIImageView!
  @IBOutlet weak var rateStarImage1: UIImageView!
  @IBOutlet weak var rateDecimalLabel: UILabel!
  @IBOutlet weak var rateLabel: UILabel!
  @IBOutlet weak var genresLabel: UILabel!
  @IBOutlet weak var watchCountLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var videoButton: UIButton!
  @IBOutlet weak var backdropImage: UIImageView!
  @IBOutlet weak var posterImage: ShadowImageView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      let rateImages = [self.rateStarImage1,self.rateStarImage2, self.rateStarImage3, self.rateStarImage4, self.rateStarImage5]
      setupNav()
      self.castCV.delegate = self
      self.castCV.dataSource = self
      self.castCV.register(UINib(nibName: "CastCVCell", bundle: nil), forCellWithReuseIdentifier: "CastCVCell")
      
      
      
      if isShow {
        
        self.networkManager.getShowDetails(showID: self.movieID) { details, error in
          if let error = error {
            print(error)
          }
          if let details = details {
            self.showDetails = details
          
            let url = URL(string: self.baseImageURL + self.showDetails.backdropPath!)
            let url2 = URL(string: self.baseImageURL + self.showDetails.posterPath)
            DispatchQueue.global().async {
              let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
              let data2 = try? Data(contentsOf: url2!)
              DispatchQueue.main.async {
                self.backdropImage.image = UIImage(data: data!)
                self.posterImage.image = UIImage(data:data2!)
                self.titleLabel.text = self.showDetails.name.uppercased()
                self.watchCountLabel.text = "\(self.showDetails.popularity) People Watching"
                self.descriptionText.text = self.showDetails.overview
                self.rateLabel.text = "\(self.showDetails.voteAverage)"
                self.rateDecimalLabel.text = ""
                self.rate(images: rateImages as! [UIImageView], rate: Double(self.showDetails.voteAverage))
                self.genresLabel.text = self.showDetails.genres.map{$0.name}.joined(separator: ", ")
                //self.adjustUITextViewHeight(arg: self.descriptionText)
                
              }
            }
          }
          
        }
        self.networkManager.getCreditsOfShow(showID: self.movieID, completion: {credits, error in
          if let error = error {
            print(error)
            
          }
          if let credits = credits {
            DispatchQueue.main.async {
              self.cast = credits.cast
              print(self.cast)
              self.castCV.reloadData()
            }
          }
        })
      }
      
      else {
        
        self.networkManager.getMovieDetails(movieID: self.movieID) { details, error in
          if let error = error {
            print(error)
          }
          if let details = details {
            self.movieDetails = details
            
            let url = URL(string: self.baseImageURL + self.movieDetails.backdropPath)
            let url2 = URL(string: self.baseImageURL + self.movieDetails.posterPath)
            DispatchQueue.global().async {
              let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
              let data2 = try? Data(contentsOf: url2!)
              DispatchQueue.main.async {
                self.backdropImage.image = UIImage(data: data!)
                self.posterImage.image = UIImage(data:data2!)
                self.titleLabel.text = self.movieDetails.title.uppercased()
                self.watchCountLabel.text = "\(self.movieDetails.popularity) People Watching"
                self.descriptionText.text = self.movieDetails.overview
                self.rateLabel.text = "\(self.movieDetails.voteAverage.toString())".substring(1)
                self.rateDecimalLabel.text = ".\(self.movieDetails.voteAverage.toString())".upstring(2)
                self.rate(images: rateImages as! [UIImageView], rate: self.movieDetails.voteAverage)
                self.genresLabel.text = self.movieDetails.genres.map{$0.name}.joined(separator: ", ")
                //self.adjustUITextViewHeight(arg: self.descriptionText)
                if self.movieDetails.video {
                  self.videoButton.isHidden = false
                }
              }
              
            }
          }
          
        }
        self.networkManager.getCreditsOfMovie(movieID: self.movieID, completion: {credits, error in
          if let error = error {
            print(error)
            
          }
          if let credits = credits {
            DispatchQueue.main.async {
              self.cast = credits.cast
              print(self.cast)
              self.castCV.reloadData()
            }
          }
        })
      }
      
      
    }
  
  func shareButtonPressed() {
   
  }
  func rate(images: [UIImageView], rate: Double) {
    switch rate {
    case 0..<2.1:
      images[0].image = #imageLiteral(resourceName: "icon-star-selected")
    case 2.1..<4.1:
      images[0].image = #imageLiteral(resourceName: "icon-star-selected")
      images[1].image = #imageLiteral(resourceName: "icon-star-selected")
    case 4.0..<6.1:
      images[0].image = #imageLiteral(resourceName: "icon-star-selected")
      images[1].image = #imageLiteral(resourceName: "icon-star-selected")
      images[2].image = #imageLiteral(resourceName: "icon-star-selected")
    case 6.0..<8.1:
      images[0].image = #imageLiteral(resourceName: "icon-star-selected")
      images[1].image = #imageLiteral(resourceName: "icon-star-selected")
      images[2].image = #imageLiteral(resourceName: "icon-star-selected")
      images[3].image = #imageLiteral(resourceName: "icon-star-selected")
    case 8.0..<10.0:
      images[0].image = #imageLiteral(resourceName: "icon-star-selected")
      images[1].image = #imageLiteral(resourceName: "icon-star-selected")
      images[2].image = #imageLiteral(resourceName: "icon-star-selected")
      images[3].image = #imageLiteral(resourceName: "icon-star-selected")
      images[4].image = #imageLiteral(resourceName: "icon-star-selected")
    default:
      for i in images {
        i.image = #imageLiteral(resourceName: "icon-star")
      }
    }
   
    
  }

  func setupNav() {
    navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: navigationController, action: #selector(UINavigationController.popViewController(animated:)))
    let button: UIButton = UIButton(type: UIButtonType.custom)
    //set image for button
    button.setImage(UIImage(named: "icon-share"), for: .normal)
    //add function for button
    button.addTarget(self, action: Selector(("shareButtonPressed")), for: .touchUpInside)
    //set frame
    button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    
    let barButton = UIBarButtonItem(customView: button)
    //assign button to navigationbar
    self.navigationItem.rightBarButtonItem = barButton
    self.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = UIColor.white
     self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
   
  }
  func adjustUITextViewHeight(arg : UITextView)
  {
    arg.translatesAutoresizingMaskIntoConstraints = true
    arg.sizeToFit()
    arg.isScrollEnabled = false
  }

  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.cast.count
  }
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = castCV.dequeueReusableCell(withReuseIdentifier: "CastCVCell", for: indexPath) as! CastCVCell
    let person = self.cast[indexPath.row]
    if let path = person.profilePath {
      let url = URL(string: self.baseImageURL + path)
      DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        DispatchQueue.main.async {
          cell.image.image = UIImage(data: data!)
          cell.nameLabel.text = person.name
          cell.roleLabel.text = person.character
          
        }
      }
    }
   
   
    return cell
    
  }
  
}




