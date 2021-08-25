//
//  WeatherResponse.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import Foundation
import UIKit

struct WeatherResponse: Codable {
    let lat: CGFloat
    let lon: CGFloat
    let current: CurrentWeatherResponse
    let hourly: [HourlyWeatherResponse]
    let daily: [DailyWeatherResponse]
}

struct HourlyWeatherResponse: Codable {
    let dt: Int
    let temp: CGFloat
    let clouds: CGFloat
}

struct CurrentWeatherResponse: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: CGFloat
}

struct DailyWeatherResponse: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let humidity: Int
    let temp: Temperature
    let clouds: CGFloat
}

struct Temperature: Codable {
    let day: CGFloat
    let min: CGFloat
    let max: CGFloat
}
