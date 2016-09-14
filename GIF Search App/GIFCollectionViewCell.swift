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
      whiteView.backgroundColor = randomColor()
      whiteView.hidden = false
      loadingAnimation.hidden = true
//      loadingAnimation.startAnimating()
      guard let urlString = gif.url else { return }
//      loadingAnimation.startAnimating()
      dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
         let url = NSURL(string: urlString)
         if let data = NSData(contentsOfURL: url!) {
            dispatch_async(dispatch_get_main_queue()) {
               self.animatableImageView!.animateWithImageData(data)
               self.sizeToFit()
//               self.loadingAnimation.stopAnimating()
               self.whiteView.hidden = true
            }
         }
         
      }
   }
   
   func randomColor() -> UIColor {
      var colors = [UIColor.purpleColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.redColor(),
                    UIColor.orangeColor(), UIColor.magentaColor()]
      let randomColor = colors[Int(arc4random_uniform(5))]
      return randomColor
   }
   
}
