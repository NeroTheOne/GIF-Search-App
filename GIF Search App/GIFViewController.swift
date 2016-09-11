//
//  GIFViewController.swift
//  GIF Search App
//
//  Created by Janmarc on 9/3/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Gifu

class GIFViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

   struct StoryBoard {
      static let collectionViewCell = "GifCell"
   }
   
//   @IBOutlet weak var collectionView: UICollectionView!
   @IBOutlet weak var gifsCollectionView: UICollectionView!
   
   
   var GIFs = [GIF]() {
      didSet{
         gifsCollectionView?.reloadData()
      }
   }
   
   override func viewDidLoad() {
      print("viewDidLoad fired")
      super.viewDidLoad()
//      collectionView.delegate = self
   }
   
   var alamoHandler = AlamofireHandler()
   
   override func viewWillAppear(animated: Bool) {
      print("viewWillAppear fired")
      super.viewWillAppear(animated)
      
      alamoHandler.getTrending { (json) in
         self.alamoHandler.getURL(json, completion: { (gifs) in
            self.GIFs = gifs
         })
      }
   }
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("numberOfItemsInSection executed")
      
      return GIFs.count
   }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GifCell", forIndexPath: indexPath) as! GIFCollectionViewCell
      
      return cell
   }
   
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
      guard let cell = cell as? GIFCollectionViewCell else { return }
      cell.whiteView.hidden = false
      cell.loadingAnimation.startAnimating()
      cell.setAnimatableImageView(GIFs[indexPath.row])
   }
   
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
      guard let cell = cell as? GIFCollectionViewCell else { return }
      cell.whiteView.hidden = false
   }
   
   
}