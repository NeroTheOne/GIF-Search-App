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
   
   var giphyDatas = [NSData]() {
      willSet{
         print("NEW giphyData added: \(newValue)")
         collectionView!.reloadData()
      }
   }
   
   var urls = [String]() {
      willSet{
         print("NEW URL added: \(newValue)")
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
         self.alamoHandler.getURL(json, completion: { (giphyURL) in
            self.urls = giphyURL
            self.alamoHandler.getData(giphyURL, completion: { (giphyData) in
               dispatch_async(dispatch_get_main_queue()) {
                  self.giphyDatas = giphyData
               }
            })
         })
      }
   }
   
   
   override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return giphyDatas.count
   }
   
   override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GifCell", forIndexPath: indexPath) as! GIFCollectionViewCell
      let data = giphyDatas[indexPath.row]
      cell.animatableImageView.animateWithImageData(data)
      
      return cell 
   }
   
}