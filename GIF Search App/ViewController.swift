//
//  ViewController.swift
//  GIF Search App
//
//  Created by Janmarc on 8/17/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import UIKit
import Alamofire
import Gifu

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  //IBOutlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  //properties
  let alamoHandler = AlamoHandler()
  let design = UIDesigns()
  var gifs = [GIF]()
  var urls = [String]()
  var data = NSData()
  
  //life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    collectionView.delegate = self
    design.searchBar(searchBar)
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  //searchBar delegates
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    alamoHandler.runAlamofire(searchText) { (URLs: [String]) -> Void in
      self.urls = URLs
      self.collectionView.reloadData()
    }
    
  }
  
  //Collection View Data Source
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return urls.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
    cell.backgroundColor = UIColor.blackColor()
    cell.GIFImageView.getData(urls[indexPath.row])
    
    return cell
  }
  
  
  
}















