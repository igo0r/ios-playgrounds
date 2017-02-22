//
//  ViewController.swift
//  theWeather
//
//  Created by Igor Lantushenko on 15/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var locationView: UILabel!
    @IBOutlet weak var tempView: UILabel!
    @IBOutlet weak var dateLabelView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()
    var forecastWeather: [CurrentWeather] = []
    var apiClient = ApiClient()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedLocation.latitude = String(currentLocation.coordinate.latitude)
            Location.sharedLocation.longitude = String(currentLocation.coordinate.longitude)
            
            getCurrentWeather()
            getForecastWeather()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherDay", for: indexPath) as! WeatherCell
        cell.configureCellWith(forecastWeather[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastWeather.count
    }
    
    func getCurrentWeather(){
        let url = apiClient.getWeatherURLWith(type: .currentWeather)
        apiClient.composeRequest(withUrl: url!) { responseObject, error in
            if let weatherData = responseObject as? [String:AnyObject] {
                self.currentWeather.fill(weatherData: weatherData)
                self.locationView.text = self.currentWeather.currentCity
                self.weatherCondition.text = self.currentWeather.currentWeatherType
                self.weatherConditionImageView.image = self.currentWeather.currentWeatherImage
                self.tempView.text = self.currentWeather.currentTemp
                self.dateLabelView.text = self.currentWeather.currentDate
            
            }
        }
    }
    
    func getForecastWeather() {
        let url = apiClient.getWeatherURLWith(type: .forecastWeather)
        apiClient.composeRequest(withUrl: url!) { responseObject, error in
            if let weatherData = responseObject as? [String:AnyObject] {
                if let list = weatherData["list"] as? [AnyObject] {
                    for item in list {
                        let currentWeather = CurrentWeather()
                        if let data = item as? [String:AnyObject] {
                            currentWeather.fillFromForecast(weatherData: data)
                        }
                        self.forecastWeather.append(currentWeather)
                    }
                }
            }
            self.forecastWeather.remove(at: 0)
            self.tableView.reloadData()
        }
    }

}

