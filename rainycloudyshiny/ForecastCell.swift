//
//  ForecastCell.swift
//  rainycloudyshiny
//
//  Created by Yaniv Hasbani on 6/11/17.
//  Copyright © 2017 Yaniv. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

  
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var weatherTypeLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var weatherTypeImage: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func updateUI(forecast : Forecast) {
    dayLabel.text = forecast.date
    maxTempLabel.text = forecast.highTemp
    minTempLabel.text = forecast.lowTemp
    weatherTypeLabel.text = forecast.weatherType
    weatherTypeImage.image = UIImage(named: forecast.weatherType)
  }
}
