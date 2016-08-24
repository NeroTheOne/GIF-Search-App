//
//  ViewController.swift
//  GIF Search App
//
//  Created by Janmarc on 8/17/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
  
  //IBOutlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
 
  //properties
  let alamoHandler = AlamoHandler()
  let design = UIDesigns()
  var gifs = [GIF]()
  
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
    alamoHandler.runAlamofire(searchText) { (GIFs: [GIF]) -> Void in
      self.gifs = GIFs
      print("DEBUG", self.gifs)
      self.collectionView.reloadData()
    }
    
  }
  
  //Collection View Data Source
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return gifs.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
    cell.backgroundColor = UIColor.blackColor()
    return cell
  }
}















