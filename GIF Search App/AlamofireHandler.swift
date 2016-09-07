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
   
   func getTrending(completion:(json:AnyObject) -> Void){
      Alamofire.request(.GET, "\(GiphyApi.host)\(GiphyApi.EndPoint.trending)",
         parameters: ["api_key": "dc6zaTOxFJmzC", "rating": "r"])
         .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
               print("JSON: \(JSON)")
               completion(json: JSON)
            }
      }
   }
   
   func getURL(json: AnyObject, completion:(giphyURL:[String]) -> Void){
      
      var urls = [String]()
      
      guard let dictionaries = json["data"] as? [NSDictionary] else { print("json[data] not found") ; return}
      
      for dictionary in dictionaries {
         guard let images = dictionary["images"] else {return}
         guard let downsized_medium = images["downsized_medium"] else {return}
         guard let url = downsized_medium!["url"] as? String else {return}
         
         urls.append(url)
      }
      
      completion(giphyURL: urls)
   }
}



