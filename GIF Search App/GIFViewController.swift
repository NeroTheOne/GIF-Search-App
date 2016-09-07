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
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   var alamoHandler = AlamofireHandler()
   var URLs: [String]? {
      willSet{
         print("URL added: \(newValue)")
      }
   }
   
   override func viewDidLoad() {
      print("viewDidLoad fired")
      super.viewDidLoad()
      collectionView.delegate = self
     
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      alamoHandler.getTrending { (json) in
         self.alamoHandler.getURL(json, completion: { (giphyURL) in
            self.URLs = giphyURL
         })
      }
   }
   
   
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 1
   }
   
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GifCell", forIndexPath: indexPath)
      
      return cell 
   }
   
}