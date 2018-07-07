//
//  PopularShowsCVCell.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 2.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import UIKit

class PopularShowsCVCell: UICollectionViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var ratingDecimalLabel: UILabel!
  @IBOutlet weak var posterImage: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    posterImage.layer.cornerRadius = CGFloat(5)
    posterImage.layer.masksToBounds = true
   
    }

}
