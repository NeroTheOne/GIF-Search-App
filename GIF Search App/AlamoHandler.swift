//
//  AlamoHandler.swift
//  GIF Search App
//
//  Created by Janmarc on 8/17/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import Alamofire

class AlamoHandler
{
  
  var json = [String:AnyObject]()
  var gifs = [GIF]()
  var gif = GIF()
  
  var urls = [String]()
  var data = [NSData]()
  
  func runAlamofire(search: String, completion: (URLs: [String]) -> Void) {
    Alamofire.request(.GET, "https://api.giphy.com/v1/gifs/search",
      parameters: ["q": search, "api_key": "dc6zaTOxFJmzC", "rating": "r"])
      .responseJSON { response in
        //print(response.request)  // original URL request
       // print(response.response) // URL response
//        print(response.data)     // server data
//        print(response.result)   // result of response serialization
        
        if let JSON = response.result.value {
          print("JSON: \(JSON)")
          self.json = JSON as! [String : AnyObject]
          
          completion(URLs: self.parseJson(JSON))
          
        }
        
    }
  }

  
//  func getData(search: String, completion: (DATA: NSData) -> Void) {
//    Alamofire.request(.GET, search,
//      parameters: nil)
//      .responseJSON { response in
//        //print(response.request)  // original URL request
//        // print(response.response) // URL response
////                print(response.data)     // server data
//        //        print(response.result)   // result of response serialization
//        
//        if let DATA = response.data {
//          print("DEBUG: DATA: \(DATA)")
//          completion(DATA: DATA)
//          
//        }
//        
//    }
//  }


  
  private func parseJson(json: AnyObject) -> [String]{
    let data = json["data"] as! [NSDictionary]
    
    for dictionary in data {
      let images = dictionary["images"]
      let downsized_medium = images!["downsized_medium"]
      let url = downsized_medium!!["url"] as? String
      
      gif = GIF(searchedURL: url)
      gifs.append(gif)
    }
    
    for gif in gifs {
      urls.append(gif.url!)
    }
    
    return urls
  }
  
}

