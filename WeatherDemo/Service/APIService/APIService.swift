//
//  APIService.swift
//  WeatherDemo
//
//  Created by Viet Le on 25/08/2021.
//

import Foundation
import Alamofire

class APIService {
    
    func getWeather(completion: ((_ weather: Weather?)-> Void)?) {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=21.02&lon=105.83&exclude=minutely&units=metric&appid=2709af9ee3a443c96e5c8a30ac695658"
        AF.request(urlString).responseData { response in
            guard let data = response.data else {
                completion?(nil)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                //decode
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                
                //convert structs -> My Model
                let weather = self.mapWeatherResponseToWeather(weatherResponse: weatherResponse)
                
                completion?(weather)
            } catch let error {
                print(error)
            }
        }
    }
}

extension APIService {
    
    func mapWeatherResponseToWeather(weatherResponse: WeatherResponse) -> Weather {
        let weather = Weather()
        
        //Convert từng thành phần
        weather.currentWeather = mapCurrentWeatherResponseToCurrentCurrentWeather(currentResponse: weatherResponse.current)
        weather.hourlyWeathers = mapHourlyWeatherResponseToHourlyWeather(hourlyResponses: weatherResponse.hourly)
        
        weather.dailyWeathers = mapDailyWeatherResponseToDailyWeather(dailyResponses: weatherResponse.daily)
        weather.todayWeather = mapDailyWeatherResponseToTodayWeather(dailyResponses: weatherResponse.daily)
        return weather
    }
    
    func mapCurrentWeatherResponseToCurrentCurrentWeather(currentResponse: CurrentWeatherResponse) -> CurrentWeather {
        let currentWeather = CurrentWeather()
        currentWeather.time = Date.init(timeIntervalSince1970: TimeInterval(currentResponse.dt))
        currentWeather.temp = currentResponse.temp
        currentWeather.isDayTime = (currentResponse.dt > currentResponse.sunrise && currentResponse.dt < currentResponse.sunset)
        return currentWeather
    }
    
    func mapHourlyWeatherResponseToHourlyWeather(hourlyResponses: [HourlyWeatherResponse]) -> [HourlyWeather] {
        
        var hourlyWeathers = [HourlyWeather]()
        for i in 1..<25 {
            let hourlyWeatherResponse = hourlyResponses[i]
            let hourlyWeather = HourlyWeather()
            hourlyWeather.time = Date.init(timeIntervalSince1970: TimeInterval(hourlyWeatherResponse.dt))
            hourlyWeather.changeRain = hourlyWeatherResponse.clouds
            hourlyWeather.temp = hourlyWeatherResponse.temp
            hourlyWeathers.append(hourlyWeather)
        }
        
        return hourlyWeathers
    }
    
    func mapDailyWeatherResponseToDailyWeather(dailyResponses: [DailyWeatherResponse]) -> [DailyWeather] {
        
        var dailyWeathers = [DailyWeather]()
        
        for i in 1..<dailyResponses.count {
            let dailyWeatherResponse = dailyResponses[i]
            let dailyWeather = DailyWeather()
            dailyWeather.time = Date.init(timeIntervalSince1970: TimeInterval(dailyWeatherResponse.dt))
            dailyWeather.minTemp = dailyWeatherResponse.temp.min
            dailyWeather.maxTemp = dailyWeatherResponse.temp.max
            dailyWeather.changeRain = dailyWeatherResponse.clouds
            
            let sunriseTime = Date.init(timeIntervalSince1970: TimeInterval(dailyWeatherResponse.sunrise))
            dailyWeather.sunrise = Sunrise(time: sunriseTime)
            
            let sunsetTime = Date.init(timeIntervalSince1970: TimeInterval(dailyWeatherResponse.sunset))
            dailyWeather.sunset = Sunset(time: sunsetTime)
            
            dailyWeathers.append(dailyWeather)
        }
        
        return dailyWeathers
    }
    
    func mapDailyWeatherResponseToTodayWeather(dailyResponses: [DailyWeatherResponse]) -> TodayWeather {
        
        let todayWeatherResponse = dailyResponses.first!
        
        let todayWeather = TodayWeather()
        todayWeather.humidity = todayWeatherResponse.humidity
        
        let sunsetTime = Date.init(timeIntervalSince1970: TimeInterval(todayWeatherResponse.sunset))
        todayWeather.sunset = Sunset(time: sunsetTime)
        
        let sunriseTime = Date.init(timeIntervalSince1970: TimeInterval(todayWeatherResponse.sunrise))
        todayWeather.sunrise = Sunrise(time: sunriseTime)
        
        todayWeather.changeRain = todayWeatherResponse.clouds
        
        return todayWeather
    }
    
}
