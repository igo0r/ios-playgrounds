//
//  WaterForm.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 30/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

enum WaterFormCondtidion {
   case WaterTemplateView
   case WaterWeekDayView
}

class DefaultWaterForm {
    
    var updateWaterForm = false
    var shouldRecreateEvents = true
    var navBarTitle = ""
    var waterCalculator = WaterCalculator()
    
    private var waterFormCondition: WaterFormCondtidion
    
    var isWaterOn: Bool {
        get {
            return UserDefaultsUtils.getWaterBeforeMeal()
        }
        set {
            UserDefaultsUtils.setWaterBeforeMeal(include: newValue)
        }
    }
    
    var waterTime: Int {
        get {
            return UserDefaultsUtils.getWaterTime()
        }
        set {
            UserDefaultsUtils.setWaterTime(minutes:  newValue)
        }
    }
    
    init(withWaterCondition: WaterFormCondtidion) {
        waterFormCondition = withWaterCondition
    }
    
    func setNavBarTitle(_ navBarTitle: String) {
        self.navBarTitle = navBarTitle
    }
    
    func getNavBarTitle() -> String {
        return navBarTitle
    }

    func setWaterFormCondition(with waterFormCondition: WaterFormCondtidion) {
        self.waterFormCondition = waterFormCondition
    }
    
    func getWaterFormCondition() -> WaterFormCondtidion {
        return waterFormCondition
    }
}
