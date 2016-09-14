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
         print("getTrending fired")
         
         Alamofire.request(.GET, "\(GiphyApi.host)\(GiphyApi.EndPoint.trending)",
            parameters: ["api_key": "dc6zaTOxFJmzC", "rating": "r", GiphyApi.Parameters.limit: "75"])
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
      
      func search(search: String, completion:(json: AnyObject?, success: Bool) -> Void) {
         print("search fired")
         
         Alamofire.request(.GET, "\(GiphyApi.host)\(GiphyApi.EndPoint.search)",
            parameters: ["q": search,"api_key": "dc6zaTOxFJmzC", "rating": "r", GiphyApi.Parameters.limit: "75"])
            .responseJSON { response in
               print(response.request)  // original URL request
               print(response.response) // URL response
               print(response.data)     // server data
               print(response.result)   // result of response serialization
               
               if let JSON = response.result.value {
                  print("JSON: \(JSON)")
                  completion(json: JSON, success: true)
               } 
         }
      }
      
      func getURL(json: AnyObject, completion:(gifs:[GIF]) -> Void){
         print("getURL fired")
         
         var gifs = [GIF]()
         
         guard let dictionaries = json["data"] as? [NSDictionary] else { print("json[data] not found") ; return}
         
         for dictionary in dictionaries {
               guard let images = dictionary["images"] else {return}
               guard let gifImage = images["downsized_medium"] else {return}
               guard let url = gifImage!["url"] as? String else { print("error getting url") ;return}
               guard let width = gifImage!["width"] as? String else {print("error getting width"); return}
               guard let height = gifImage!["height"] as? String else {return}

               let gif = GIF(url: url, width: width, height: height)
               gifs.append(gif)
         }
         
         completion(gifs: gifs)
      }
   }
   
   
   
