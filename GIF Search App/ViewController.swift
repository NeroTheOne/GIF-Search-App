//
//  ViewController.swift
//  GIF Search App
//
//  Created by Janmarc on 8/17/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
  
  var alamoHandler = AlamoHandler()
  var gifs = [GIF]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    alamoHandler.runAlamofire()
    
  }




}

