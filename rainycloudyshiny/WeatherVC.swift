//
//  WeatherVC.swift
//  rainycloudyshiny
//
//  Created by Yaniv Hasbani on 6/9/17.
//  Copyright © 2017 Yaniv. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
  //Main view outles
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var currentTempLabel: UILabel!
  @IBOutlet var locationLabel: UILabel!
  @IBOutlet var currentWeatherImage: UIImageView!
  @IBOutlet var currentWeatherTypeLabel: UILabel!
  //Lower tableView
  @IBOutlet var tableView: UITableView!
  
  var locationManager = CLLocationManager()
  var currentLocation: CLLocation!
  var currentWeather = CurrentWeather()
  var forecasts: [Forecast]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startMonitoringSignificantLocationChanges()
    
    tableView.delegate = self
    tableView.dataSource = self
    forecasts = []
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    locationAuthStatus()
    
    currentWeather.downloadWeatherDetails(completed: {
      self.downloadForecastDate(completed: {
        self.updateMainUI()
      });
    })
  }
  
  func downloadForecastDate(completed:@escaping DownloadComplete) {
    let forecastURL = URL(string: FORECAST_URL)
    
    Alamofire.request(forecastURL!).responseJSON { response in
        let result = response.result
      
        if let dict = result.value as? Dictionary<String,AnyObject> {
          if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
            
            for obj in list {
                let forecast = Forecast(weatherDict:obj)
                self.forecasts.append(forecast)
            }
            self.forecasts.remove(at: 0)
            self.tableView.reloadData()
          }
        }
      completed()
    }
  }
  
// MARK:TableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecasts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell{
      if indexPath.row < forecasts.count {
        let forecast = forecasts[indexPath.row]
        
        cell.updateUI(forecast: forecast)
        
        return cell
      }
    }
    
    return UITableViewCell()
  }
  
  func updateMainUI() {
    dateLabel.text = currentWeather.date
    currentTempLabel.text = "\(currentWeather.currentTemp)"
    locationLabel.text = currentWeather.cityName
    currentWeatherTypeLabel.text = currentWeather._weatherType
    currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
  }
  
// MARK: LocationDelegate
  func locationAuthStatus() {
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      currentLocation = locationManager.location
      Location.sharedInstance.lat = currentLocation.coordinate.latitude
      Location.sharedInstance.long = currentLocation.coordinate.longitude
    } else {
      //Not yet authorized
      locationManager.requestWhenInUseAuthorization()
      locationAuthStatus()
    }
  }
}

