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

class GIFViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UINavigationBarDelegate {
   
   // MARK: Model
   var lastSearch: String?
   
   // MARK: IBOutlets
   
   @IBOutlet weak var gifsCollectionView: UICollectionView!
   @IBOutlet weak var gifSearchBar: UISearchBar!
   @IBOutlet weak var searchNotFoundLabels: UIStackView!
   @IBOutlet weak var searchLabel: UILabel!
   
   
   // MARK: Variables
   
   var GIFs = [GIF]() {
      didSet{
         gifsCollectionView?.reloadData()
      }
   }
   
   let alamoHandler = AlamofireHandler()
   
   //MARK: LifeCycle
   
   override func viewDidLoad() {
      print("viewDidLoad fired")
      super.viewDidLoad()
      gifSearchBar.delegate = self
      gifSearchBar.barStyle = UIBarStyle.BlackTranslucent
      navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
      navigationController!.navigationBar.barTintColor = UIColor.clearColor()
   }
   
   override func viewWillAppear(animated: Bool) {
      print("viewWillAppear fired")
      super.viewWillAppear(animated)
      
      alamoHandler.getTrending { (json) in
         self.alamoHandler.getURL(json, completion: { (gifs) in
            dispatch_async(dispatch_get_main_queue()) {
               self.GIFs = gifs
               self.title = "Trending"
            }
         })
      }
   }
   
   // MARK: IBActions
   
   
   
   // MARK: Collection View Delegate & Data Source
   
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      print("numberOfItemsInSection executed")
      
      return GIFs.count
   }
   
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      print("cellForItemAtIndexPath fired")
      
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("GifCell", forIndexPath: indexPath) as! GIFCollectionViewCell
      
      return cell
   }
   
   var gifImageHeight: CGFloat?
   
   func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
      print("willDisplayCell fired")
      
      guard let cell = cell as? GIFCollectionViewCell else { return }
      let gif = GIFs[indexPath.row]
      
      cell.setAnimatableImageView(gif)
      
      let imageViewHeight = cell.animatableImageView.frame.height
      print("DEBUG image: \(gif.url) indexPath: \(indexPath.row) imageViewHeight: ", imageViewHeight)
   }
   
   func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
      guard let cell = cell as? GIFCollectionViewCell else { return }
      cell.whiteView.hidden = false
   }
   
   func scrollViewDidScroll(scrollView: UIScrollView) {
      if gifSearchBar.isFirstResponder() {
         gifSearchBar.resignFirstResponder()
      }
   }
   
   func collectionView(collectionView: UICollectionView,
                       layout collectionViewLayout: UICollectionViewLayout,
                              sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      print("== \(indexPath.row) ===")
      
      let gif = GIFs[indexPath.row]
      
      var gifHeight = CGFloat(Int(gif.height!)!)
      print("height: \(gifHeight)")
      var gifWidth = CGFloat(Int(gif.width!)!)
      print("width: \(gifWidth)")
      let maxWidth = view.frame.width
      
      
      if gifWidth > maxWidth {
         print("maxWidth: \(maxWidth)")
         let excessWidth = gifWidth - maxWidth
         print("DEBUG excessWidth: ", excessWidth)
         let percentage = 100 * (excessWidth / gifWidth) / 100
         print("DEBUG percentage: ", percentage)
         let heightPercentage = percentage * gifHeight
         print("heightPercentage: \(heightPercentage)")
         
         gifWidth = maxWidth
         gifHeight -= heightPercentage 
      }
      
      return CGSizeMake(gifWidth, gifHeight)
   }
   
   
   // MARK: Search Bard Delegates
   
   func searchBarSearchButtonClicked(searchBar: UISearchBar) {
      print("searchBarSearchButtonClicked fired")
      searchNotFoundLabels.hidden = true
      
      if let text = searchBar.text where !text.isEmpty {
         
         if searchBar.text == lastSearch {
            searchBar.resignFirstResponder()
         } else {
            
            alamoHandler.search(text, completion: { (json, success) in
               self.alamoHandler.getURL(json!, completion: { (gifs) in
                  if !gifs.isEmpty {
                     self.GIFs = gifs
                  } else {
                     self.GIFs = gifs
                     self.searchNotFoundLabels.hidden = false
                  }
                  self.title = text.uppercaseString
               })
            })
         }
         
         
         searchBar.resignFirstResponder()
      }
   }
}













