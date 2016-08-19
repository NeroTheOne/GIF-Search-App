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

  func runAlamofire() {
    Alamofire.request(.GET, "https://api.giphy.com/v1/gifs?api_key=dc6zaTOxFJmzC&ids=feqkVgjJpYtjy,7rzbxdu0ZEXLy", parameters: nil)
      .responseJSON { response in
        print(response.request)  // original URL request
        print(response.response) // URL response
        print(response.data)     // server data
        print(response.result)   // result of response serialization
        
        if let JSON = response.result.value {
          print("JSON: \(JSON)")
        }
    }
  }
  
  
}

