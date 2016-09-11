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
            parameters: ["api_key": "dc6zaTOxFJmzC", "rating": "r", GiphyApi.Parameters.limit: "10"])
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
      
      func getURL(json: AnyObject, completion:(gifs:[GIF]) -> Void){
         print("getURL fired")
         
         var gifs = [GIF]()
         
         guard let dictionaries = json["data"] as? [NSDictionary] else { print("json[data] not found") ; return}
         
         for dictionary in dictionaries {
            guard let images = dictionary["images"] else {return}
            guard let downsized_medium = images["downsized_medium"] else {return}
            guard let url = downsized_medium!["url"] as? String else {return}
            
            let gif = GIF(url: url)
            gifs.append(gif)
         }
         
         completion(gifs: gifs)
      }
      
      func getData(urls:[String], completion:(giphyData:[NSData]) -> Void){
         print("getData fired")
         
         var datas = [NSData]()
         
         for url in urls {
            print("URL being converted to data: ", url)
            guard let nsUrl = NSURL(string: url) else {return}
            guard let data = NSData(contentsOfURL: nsUrl) else {return}
            datas.append(data)
         }
         
         completion(giphyData: datas)
      }
   }
   
   
   
