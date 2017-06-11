//
//  Forecast.swift
//  rainycloudyshiny
//
//  Created by Yaniv Hasbani on 6/11/17.
//  Copyright © 2017 Yaniv. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
  var _date: String!
  var _weatherType: String!
  var _highTemp: String!
  var _lowTemp: String!
  
  var date: String {
    if _date == nil {
      _date = ""
    }
    
    return _date
  }
  
  var weatherType: String {
    if _weatherType == nil {
      _weatherType = ""
    }
    
    return _weatherType
  }
  
  var highTemp: String {
    if _highTemp == nil {
      _highTemp = ""
    }
    
    return _highTemp
  }
  
  var lowTemp: String {
    if _lowTemp == nil {
      _lowTemp = ""
    }
    
    return _lowTemp
  }
  
  init(weatherDict:(Dictionary<String, AnyObject>)) {
    if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
      if var minTemp = temp["min"] as? Double {
        self._lowTemp = "\(minTemp.kelvinToCelcius())"
      }
      
      if var maxTemp = temp["max"] as? Double {
        self._highTemp = "\(maxTemp.kelvinToCelcius())"
      }
    }
    
    if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
      if let weatherType = weather[0]["main"] as? String{
        self._weatherType = weatherType
      }
    }
    
    if var date = weatherDict["dt"] as? Double {
      self._date = date.timestampToDate()
    }
  }
}
