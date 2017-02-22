//
//  ApiClient.swift
//  theWeather
//
//  Created by Igor Lantushenko on 17/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherUrl: String {
    case currentWeather = "weather"
    case forecastWeather = "forecast/daily"
}

struct ApiClient {
    
    let BASE_URL = "http://samples.openweathermap.org/data/2.5/"
    let APP_ID = "b1b15e88fa797225412429c1c50c122a1"

    func getWeatherURLWith(type: WeatherUrl) -> URL? {
        let lat = Location.sharedLocation.latitude
        let lon = Location.sharedLocation.longitude
        let url = BASE_URL + type.rawValue
        
        if let urlComp = NSURLComponents(string:url) {
            var queryItems: [NSURLQueryItem] = []
            queryItems.append(NSURLQueryItem(name: "lat", value: lat))
            queryItems.append(NSURLQueryItem(name: "lon", value: lon))
            if type == .forecastWeather {
                queryItems.append(NSURLQueryItem(name: "cnt", value: "16"))
            }
            queryItems.append(NSURLQueryItem(name: "appid", value: APP_ID))
            urlComp.queryItems = queryItems as [URLQueryItem]?
            return urlComp.url
        }
    
        return nil
    }

    func composeRequest(withUrl url: URL, completionHandler: @escaping (AnyObject?, NSError?) -> ()){
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler(value as AnyObject?, nil)
            case .failure(let error):
                completionHandler(nil, error as NSError?)
            }
        }
    }
}
