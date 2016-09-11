//
//  URLLoadOperation.swift
//  GIF Search App
//
//  Created by Janmarc on 9/8/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
protocol GetURLOperationDataProvider {
   var giphyJson: AnyObject? { get }
}

class GetURLOperation: ConcurrentOperation {
   var urls: String?
   var inputJson: AnyObject?
   
   var alamoHandler = AlamofireHandler()
   override func main() {
      let dataProvider = dependencies
         .filter { $0 is GetURLOperationDataProvider }
         .first as? GetURLOperationDataProvider
      inputJson = dataProvider?.giphyJson
      
      guard let inputJson = self.inputJson else { return }
      alamoHandler.getURL(inputJson) { (giphyURL) in
         self.urls = giphyURL
         self.state = .Finished
      }
   }
   
}

extension GetURLOperation: GetDataOperationDataProvider {
   var giphyUrls: [String]? { return urls }
}
