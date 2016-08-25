//
//  Extentions .swift
//  GIF Search App
//
//  Created by Janmarc on 8/24/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import Alamofire
import Gifu


extension AnimatableImageView {
  
  func getData(search: String) {
    Alamofire.request(.GET, search, parameters: nil)
      .validate()
      .response { request, response, data, error in
        print(request)
        print(response)
        print("DEBUG YEAH",data)
        print(error)
        
        if let DATA = data {
          self.animateWithImageData(DATA)
        }
    }
    
  }
}
