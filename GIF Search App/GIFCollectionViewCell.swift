//
//  GIFCollectionViewCell.swift
//  GIF Search App
//
//  Created by Janmarc on 9/7/16.
//  Copyright © 2016 Nero. All rights reserved.
//
import Foundation
import UIKit
import Gifu

class GIFCollectionViewCell: UICollectionViewCell {

   @IBOutlet weak var animatableImageView: GIFAnimatableImageView!
   @IBOutlet weak var whiteView: UIView!
   @IBOutlet weak var loadingAnimation: UIActivityIndicatorView!
   
   func setAnimatableImageView(gif: GIF) {
      guard let urlString = gif.url else { return }
      loadingAnimation.startAnimating()
      dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
         let url = NSURL(string: urlString)
         if let data = NSData(contentsOfURL: url!) {
            dispatch_async(dispatch_get_main_queue()) {
               self.animatableImageView!.animateWithImageData(data)
               self.sizeToFit()
               self.loadingAnimation.stopAnimating()
               self.whiteView.hidden = true
            }
         }
         
      }
   }
   
}
