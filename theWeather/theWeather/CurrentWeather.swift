//
//  CurrentWeather.swift
//  theWeather
//
//  Created by Igor Lantushenko on 18/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit


class CurrentWeather {
    private var _currentTemp: String = ""
    private var _currentMinTemp: String = ""
    private var _currentMaxTemp: String = ""
    private var _currentCity: String = ""
    private var _currentDate: String = ""
    private var _currentWeatherType: String = ""
    private var _currentWeatherImage: UIImage = UIImage()
    
    private var unixDateFormatter = DateFormatter()
    
    var currentTemp: String {
        get {
            return _currentTemp
        } set {
            _currentTemp = newValue
        }
    }
    
    var currentMinTemp: String {
        get {
            return _currentMinTemp
        } set {
            _currentMinTemp = newValue
        }
    }

    var currentMaxTemp: String {
        get {
            return _currentMaxTemp
        } set {
            _currentMaxTemp = newValue
        }
    }

    
    var currentCity: String {
        get {
            return _currentCity
        } set {
            _currentCity = newValue
        }
    }
    
    var currentDate: String {
        get {
            if _currentDate == "" {
                let dateFormater = DateFormatter()
                dateFormater.dateStyle = .long
                dateFormater.timeStyle = .none
                let currentDate = dateFormater.string(from: Date())
                _currentDate = "Today, \(currentDate)"
            }
            return _currentDate
        } set {
            _currentDate = newValue
        }
    }
    
    var currentWeatherType: String {
        get {
            return _currentWeatherType
        } set {
            _currentWeatherType = newValue
        }
    }
    
    var currentWeatherImage: UIImage {
        get {
            return _currentWeatherImage
        } set {
            _currentWeatherImage = newValue
        }
    }
    
    func fill(weatherData: [String:AnyObject]) {
        if let name = weatherData["name"] as? String {
            self.currentCity = name
        }
        if let weather = weatherData["weather"] as? [AnyObject] {
            if let type = weather[0]["main"] as? String {
                self.currentWeatherType = type
                self.currentWeatherImage = UIImage(named: type)!
            }
        }
        if let main = weatherData["main"] as? [String:AnyObject] {
            if let temp = main["temp"] as? Double {
                let currentTemp = kelvinToCelcium(Int(temp))
                self.currentTemp = "\(currentTemp)"
                
            }
        }

    }
    
    func fillFromForecast(weatherData: [String:AnyObject]) {
        if let date = weatherData["dt"] as? Int64 {
            self.currentDate = self.unixToWeekDayFormat(String(date))
        }
        if let weather = weatherData["weather"] as? [AnyObject] {
            if let type = weather[0]["main"] as? String {
                self.currentWeatherType = type
                self.currentWeatherImage = UIImage(named: type)!
            }
        }
        if let temp = weatherData["temp"] as? [String:AnyObject] {
            if let minTemp = temp["min"] as? Double {
                self.currentMinTemp = "\(kelvinToCelcium(Int(minTemp)))"
            }
            if let maxTemp = temp["max"] as? Double {
                self.currentMaxTemp = "\(kelvinToCelcium(Int(maxTemp)))"
            }
        }
        
    }
    
    func unixToWeekDayFormat(_ unix: String) -> String
    {
        unixDateFormatter.dateFormat = "EEEE"
        let date = Date(timeIntervalSince1970: TimeInterval(unix)!)
        return unixDateFormatter.string(from: date)
    }
    
    func kelvinToCelcium(_ kelvin: Int) -> Int{
        return Int(kelvin - 273)
    }
}
