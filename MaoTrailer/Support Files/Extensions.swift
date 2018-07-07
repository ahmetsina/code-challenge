//
//  Extensions.swift
//  MaoTrailer
//
//  Created by Ahmet Sina on 2.07.2018.
//  Copyright © 2018 Ahmet Sina Ustem. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
  func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
        else { return }
      DispatchQueue.main.async() {
        self.image = image
      }
      }.resume()
  }
  func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloadedFrom(url: url, contentMode: mode)
  }
}

extension Double {
    func toString() -> String {
      return String(format: "%.1f",self)
    }
  }

extension String {
  
  func substring(_ to: Int) -> String {
    let start = index(startIndex, offsetBy: to)
    return String(self[..<start])
  }
  func upstring(_ from: Int) -> String {
    let start = index(self.startIndex, offsetBy: from)
    return String(self[start..<endIndex])
  }
  
}
extension UIView {
  
  func findCollectionView() -> UICollectionView? {
    if let collectionView = self as? UICollectionView {
      return collectionView
    } else {
      return superview?.findCollectionView()
    }
  }
  
  func findCollectionViewCell() -> UICollectionViewCell? {
    if let cell = self as? UICollectionViewCell {
      return cell
    } else {
      return superview?.findCollectionViewCell()
    }
  }
  
  func findCollectionViewIndexPath() -> IndexPath? {
    guard let cell = findCollectionViewCell(), let collectionView = cell.findCollectionView() else { return nil }
    
    return collectionView.indexPath(for: cell)
  }
  
}


class PaddingLabel: UILabel {
  
  @IBInspectable var topInset: CGFloat = 5.0
  @IBInspectable var bottomInset: CGFloat = 5.0
  @IBInspectable var leftInset: CGFloat = 5.0
  @IBInspectable var rightInset: CGFloat = 5.0
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
  
  override var intrinsicContentSize: CGSize {
    get {
      var contentSize = super.intrinsicContentSize
      contentSize.height += topInset + bottomInset
      contentSize.width += leftInset + rightInset
      return contentSize
    }
  }
}
