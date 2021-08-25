//
//  HourlyWeather.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import Foundation
import UIKit

class HourlyWeather: NSObject {
    var time: Date!
    var temp: CGFloat!
    var changeRain: CGFloat!
    
    var day: Int? {
        return time.day
    }
    
    var hour: Int? {
        return time.hour
    }
}
