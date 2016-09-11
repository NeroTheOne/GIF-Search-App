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

class GIFViewController: UICollectionViewController {//UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   struct StoryBoard {
      static let collectionViewCell = "GifCell"
   }
   
//   @IBOutlet weak var collectionView: UICollectionView!
   
   var GIFs = [GIF]() {
      didSet{
         collectionView?.reloadData()
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
   
   
   override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("numberOfItemsInSection executed")
      
      return GIFs.count
   }
   
   override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
      
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GifCell", forIndexPath: indexPath) as! GIFCollectionViewCell
   
      return cell
   }
   
}