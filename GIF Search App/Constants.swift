//
//  Constants.swift
//  GIF Search App
//
//  Created by Janmarc on 9/3/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation

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

struct StoryBoard {
   static let collectionViewCell = "GifCell"
}
