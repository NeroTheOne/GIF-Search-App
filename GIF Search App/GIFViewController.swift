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
      var currentSearch: String?
   
   // MARK: IBOutlets
   
   @IBOutlet weak var gifsCollectionView: UICollectionView!
   @IBOutlet weak var gifSearchBar: UISearchBar!
   
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
      
      cell.whiteView.hidden = false
      cell.loadingAnimation.startAnimating()
      cell.setAnimatableImageView(gif)
      
      let imageViewHeight = cell.animatableImageView.frame.height
      print("DEBUG image: \(gif.url) indexPath: \(indexPath.row) imageViewHeight: ", imageViewHeight)
   }
   
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
      guard let cell = cell as? GIFCollectionViewCell else { return }
      cell.whiteView.hidden = false
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
         let percentage = 100 * (excessWidth / maxWidth) / 100
            print("DEBUG percentage: ", percentage)
         let heightPercentage = percentage * gifHeight
            print("heightPercentage: \(heightPercentage)")
         
         gifWidth = maxWidth
//         gifHeight -= (heightPercentage - 20)
      }
      
      return CGSizeMake(gifWidth, gifHeight)
   }
   
   
   // MARK: Search Bard Delegates
   
   func searchBarSearchButtonClicked(searchBar: UISearchBar) {
      print("searchBarSearchButtonClicked fired")
      
      if let text = searchBar.text where !text.isEmpty {
         if searchBar.text == currentSearch {
            searchBar.resignFirstResponder()
            print("text = currentSearch")
            print("currentSearch: \(currentSearch), text: \(text)")
         } else {
            alamoHandler.search(text) { (json) in
               self.alamoHandler.getURL(json, completion: { (gifs) in
                  self.GIFs = gifs
                  self.title = text.uppercaseString
                  self.currentSearch = text
                  print("currentSearch: \(self.currentSearch), text: \(text)")
               })
            }
         }
      }
      
      searchBar.resignFirstResponder()
   }
   
   func searchBarCancelButtonClicked(searchBar: UISearchBar) {
      print("searchBarCancelButtonClicked")
      if searchBar.isFirstResponder() {
         searchBar.resignFirstResponder()
      }
   }
   

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}