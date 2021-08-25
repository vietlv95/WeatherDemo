//
//  TimelineCell.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import UIKit

class TimelineCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(data: AnyObject) {
        if let currentWeather = data as? CurrentWeather {
            //update UI for current weather cell
        } else if let hourlyWeather = data as? HourlyWeather {
            //update UI for hourly weather
        }
    }
}
