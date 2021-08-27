//
//  TimelineCell.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import UIKit

class TimelineCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var changeRainLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(data: Timeline) {
        if let currentWeather = data as? CurrentWeather {
            titleLabel.text = "Now"
            iconView.image = UIImage(named: currentWeather.isDayTime ? "ic_sun" : "ic_night")
            changeRainLabel.isHidden = true
            tempLabel.text = "\(Int(currentWeather.temp))°"
        } else if let hourlyWeather = data as? HourlyWeather {
            titleLabel.text = String(format: "%02ld", hourlyWeather.hour)
            
            iconView.image = UIImage(named: "ic_cloud")
            changeRainLabel.isHidden = false
            changeRainLabel.text = "\(Int(hourlyWeather.changeRain!))%"
            tempLabel.text = "\(Int(hourlyWeather.temp!))°"
        } else if let sunrise = data as? Sunrise {
            titleLabel.text = sunrise.timeString
            iconView.image = UIImage(named: "ic_sunrise")
            changeRainLabel.isHidden = true
            tempLabel.text = "Sunrise"
        } else if let sunset = data as? Sunset {
            titleLabel.text = sunset.timeString
            iconView.image = UIImage(named: "ic_sunset")
            changeRainLabel.isHidden = true
            tempLabel.text = "Sunset"
        }
    }
}
