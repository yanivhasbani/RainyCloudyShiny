//
//  Consts.swift
//  rainycloudyshiny
//
//  Created by Yaniv Hasbani on 6/10/17.
//  Copyright © 2017 Yaniv. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/"

//Routes
let CURRENT_WEATHER_ROUTE = "weather?"
let FORECAST_DAILY_ROUTE = "forecast/daily?"

//Parameters
let LATITUDE = "lat="
let LONGTITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "3401903871238d00de633c9c7d88ea22"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER_ROUTE)\(LATITUDE)\(Location.sharedInstance.lat!)\(LONGTITUDE)\(Location.sharedInstance.long!)\(APP_ID)\(API_KEY)"
let FORECAST_URL = "\(BASE_URL)\(FORECAST_DAILY_ROUTE)\(LATITUDE)\(Location.sharedInstance.lat!)\(LONGTITUDE)\(Location.sharedInstance.long!)\(APP_ID)\(API_KEY)"

typealias DownloadComplete = () -> ()


extension Double {
  mutating func kelvinToCelcius() -> Double {
    return Double(Darwin.round(self - 273.15))
  }
  
  mutating func timestampToDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let convertedTimestamp = Date(timeIntervalSince1970: self)
    return dateFormatter.string(from: convertedTimestamp)
  }
}
//lat=35&lon=139&appid=3401903871238d00de633c9c7d88ea22
