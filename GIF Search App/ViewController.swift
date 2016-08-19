//
//  ViewController.swift
//  GIF Search App
//
//  Created by Janmarc on 8/17/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UISearchBarDelegate {
  
  //IBOutlets
  @IBOutlet weak var searchBar: UISearchBar!
 
  //properties
  let alamoHandler = AlamoHandler()
  let design = UIDesigns()
  var gifs = [GIF]()
  
  //life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    design.searchBar(searchBar)
    
  }
  
  //searchBar delegates
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    alamoHandler.runAlamofire(searchText)
  }
  
  
}

