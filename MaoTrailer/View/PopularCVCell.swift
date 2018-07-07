//
//  PopularCVCell.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 2.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import UIKit

class PopularCVCell: UICollectionViewCell {

  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var backgroundImage: ShadowImageView!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var ratingDecimalLabel: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
  
        // Initialization code
    }
  
}
