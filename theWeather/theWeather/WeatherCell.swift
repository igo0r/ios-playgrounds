//
//  weatherCell.swift
//  theWeather
//
//  Created by Igor Lantushenko on 17/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var nightTemperatureView: UILabel!
    @IBOutlet weak var dayTemperatureView: UILabel!
    @IBOutlet weak var typeWeatherView: UILabel!
    @IBOutlet weak var weekDayView: UILabel!
    
    func configureCellWith(_ currentWeather: CurrentWeather){
        weatherImageView.image = currentWeather.currentWeatherImage
        nightTemperatureView.text = currentWeather.currentMinTemp
        dayTemperatureView.text = currentWeather.currentMaxTemp
        typeWeatherView.text = currentWeather.currentWeatherType
        weekDayView.text = currentWeather.currentDate
    }

}
