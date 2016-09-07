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
   
   var datas: [NSData]? {
      willSet{
         print("Data added: \(newValue)")
      }
   }
   
   override func viewDidLoad() {
      print("viewDidLoad fired")
      super.viewDidLoad()
      collectionView.delegate = self
     
   }
   
   var alamoHandler = AlamofireHandler()
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      alamoHandler.getTrending { (json) in
         self.alamoHandler.getURL(json, completion: { (giphyURL) in
            self.alamoHandler.getData(giphyURL, completion: { (giphyData) in
               self.datas = giphyData
            })
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