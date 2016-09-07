//
//  AlamofireHandler.swift
//  GIF Search App
//
//  Created by Janmarc on 9/3/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireHandler {
   
   func getTrending(completion:(urls:[String]) -> Void){
      Alamofire.request(.GET, "\(GiphyApi.host)\(GiphyApi.EndPoint.trending)",
         parameters: ["api_key": "dc6zaTOxFJmzC", "rating": "r"])
         .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
               print("JSON: \(JSON)")
               dispatch_async(dispatch_get_main_queue()) {
                  completion(urls: self.getURL(JSON))
               }
            }
            
      }
   }
   
   func getURL(json: AnyObject) -> [String]{
      print("getURL executed")
      if let data = json["data"] as? [NSDictionary] {
         print("json[data]")print("Hey")
         print("")
         for dictionary in data {
            let images = dictionary["images"]!
            let downsized_medium = images["downsized_medium"]!
            let url = downsized_medium!["url"] as? String
            print("GIF URL: \(url!)")
   
            }
         }
   }
}

struct GiphyApi {
   static let host = "https://api.giphy.com"
   static let apiKey = "dc6zaTOxFJmzC"
   
   struct EndPoint {
      static let search = "/v1/gifs/search"
      static let trending = "/v1/gifs/trending"
   }
   
   struct Parameters {
      static let query = "q"
      static let limit = "limit"
      static let offset = "offset"
      static let rating = "rating"
      static let format = "fmt"
   }
}


