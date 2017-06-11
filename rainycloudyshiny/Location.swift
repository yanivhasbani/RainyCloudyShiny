//
//  Location.swift
//  rainycloudyshiny
//
//  Created by Yaniv Hasbani on 6/11/17.
//  Copyright © 2017 Yaniv. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
  //Only I can call init!! - This is a SINGELTON!
  static var sharedInstance = Location()
  private init() {}
  
  var lat: Double!
  var long: Double!
}
