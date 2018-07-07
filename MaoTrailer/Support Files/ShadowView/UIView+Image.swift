//
//  UIView+Image.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 4.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import UIKit

extension UIView{
  
  ///Returns a UIImage copy of the view
  internal func convertToImage(completion:@escaping (UIImage) -> Void){
    
    DispatchQueue.main.async {
      let layer = self.layer
      let size = layer.frame.size
      
      DispatchQueue.global(qos: .utility).async {
        let image = layer.getImage(size: size)
        completion(image)
      }
    }
  }
}

extension CALayer{
  
  func getImage(size:CGSize) -> UIImage{
    
    UIGraphicsBeginImageContext(size)
    guard let currentContext = UIGraphicsGetCurrentContext()else{return UIImage()}
    render(in:currentContext)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    guard let cgImage = image?.cgImage else{return UIImage()}
    return UIImage.init(cgImage: cgImage)
  }
  
  ///Returns a UIImage copy of the layer
  internal var asImage : UIImage{
    
    return self.getImage(size: self.frame.size)
  }
}
