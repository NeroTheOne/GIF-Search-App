//
//  GetJsonOperation.swift
//  GIF Search App
//
//  Created by Janmarc on 9/8/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import Gifu

class GetJsonOperation: ConcurrentOperation {
   
   var json: AnyObject?
   
   var alamoHandler = AlamofireHandler()
   override func main() {
      alamoHandler.getTrending { (json) in
         self.json = json
         self.state = .Finished
      }
   }
   
}

extension GetJsonOperation: GetURLOperationDataProvider {
   var giphyJson: AnyObject? { return json }
}