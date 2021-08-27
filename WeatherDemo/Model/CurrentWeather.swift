//
//  NowWeather.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import Foundation
import UIKit

class CurrentWeather: NSObject, Timeline {
    var time: Date!
    var temp: CGFloat!
    var isDayTime: Bool!
    
    func getTime() -> Date {
        return time
    }
}
