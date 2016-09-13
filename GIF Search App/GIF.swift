//
//  GIFModel.swift
//  GIF Search App
//
//  Created by Janmarc on 9/10/16.
//  Copyright © 2016 Nero. All rights reserved.
//

import Foundation
import Gifu

class GIF {
   
   
   var url: String?
   var data: NSData?
   var width: String?
   var height: String?
   
   init(url: String, width: String, height: String) {
      self.url = url
      self.width = width
      self.height = height
   }
   

}