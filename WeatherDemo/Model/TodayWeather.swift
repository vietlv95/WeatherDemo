//
//  TodayWeather.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import Foundation
import UIKit

class TodayWeather {
    var sunrise: Date!
    var sunset: Date!
    var changeRain: CGFloat!
    var humidity: Int!
    
    var weekDay: Int {
        return sunset.weekday
    }
}
