//
//  CellImageView.swift
//  Code Challenge
//
//  Created by Rahul Patil on 23/10/20.
//

import Foundation
import UIKit
import Alamofire

let imagesCache = NSCache<NSString, AnyObject>()
class CellImageView: UIImageView {
  //MARK: Variables
  private var activityIndicator = UIActivityIndicatorView()
  var request: DataRequest?
  var urlString: String?
  
  //MARK: Initialize
  init() {
    super.init(frame: .zero)
    addSubview(activityIndicator)
    
    // Set constraints of activitiy indicator.
    activityIndicator.snp.makeConstraints { (maker) in
      maker.center.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: Custom methods
  
  /// It fetch the Image from the URL and set to the view. Also fetched iamge stored in the images cache for the further use.
  /// - Parameter url: String
  func setImg(from url: String) {
    urlString = url
    activityIndicator(animate: true)
    
    // Check and set iamge from the cache memory.
    if let _image = imagesCache.object(forKey: NSString(string: url)) as? UIImage {
      image = _image
      activityIndicator(animate: false)
      return
    }
    
    // Fetche the image from the URL
    AF.request(url).validate().responseData { [weak self] (respone) in
      guard let self = self else {return}
      if respone.error == nil {
        if let _data = respone.data, let _image = UIImage(data: _data) {
          if self.urlString == url {
            self.image = _image
          }
          // Save the iamge in the image cache.
          imagesCache.setObject(_image, forKey: NSString(string: url))
          self.activityIndicator(animate: false)
        }
      } else {
        self.image = UIImage(named: "Error")
        self.activityIndicator(animate: false)
      }
    }
  }
  
  /// It handles the visibility and animation of Activity Indicator.
  /// - Parameter animate: Bool
  private func activityIndicator(animate: Bool) {
    if animate {
      activityIndicator.isHidden = false
      activityIndicator.startAnimating()
    } else {
      activityIndicator.isHidden = true
      activityIndicator.stopAnimating()
    }
  }
}
