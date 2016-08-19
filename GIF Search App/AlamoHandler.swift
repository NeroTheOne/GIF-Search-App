//
//  AlamoHandler.swift
//  GIF Search App
//
//  Created by Janmarc on 8/17/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import Alamofire

class AlamoHandler {

  var json = [String:AnyObject]()
  var gifs = [GIF]()
  
  func runAlamofire() {
    Alamofire.request(.GET, "https://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC", parameters: nil)
      .responseJSON { response in
        //print(response.request)  // original URL request
        print(response.response) // URL response
        // print(response.data)     // server data
        print(response.result)   // result of response serialization
        
        if let JSON = response.result.value {
          print("JSON: \(JSON)")
          self.parseJson(JSON)
        }
    }
  }
  
  func parseJson(json: AnyObject) {
    let data = json["data"] as! [NSDictionary]
    
    for dictionary in data {
      let url = dictionary["embed_url"] as! String
      print(url)
    }
  }
  
  
}

