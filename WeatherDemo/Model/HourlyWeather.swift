//
//  HourlyWeather.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import Foundation
import UIKit

class HourlyWeather: NSObject, Timeline {
    var time: Date!
    var temp: CGFloat!
    var changeRain: CGFloat!
    
    var day: Int {
        return time.day
    }
    
    var hour: Int {
        return time.hour
    }
    
    func getTime() -> Date {
        return time
    }
}
