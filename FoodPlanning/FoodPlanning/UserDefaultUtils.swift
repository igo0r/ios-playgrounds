//
//  UserDefaultUtils.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 11/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class UserDefaultsUtils {
    
    /*
     Return Starts from 1 to 7
     */
    static func getDefaultUserDate() -> WeekDays {
        let defaultDayStr = UserDefaults.standard.integer(forKey: defaultUserDayKey)

        let weekDay:WeekDays
        if defaultDayStr == 0 {
            weekDay = DateTimeUtils.getCurrentWeekDayNumber()
        } else {
            weekDay = WeekDays(rawValue: defaultDayStr - 1)!
        }
        
        return weekDay
    }
    
    static func setDefaultUserDate(weekDay: WeekDays) {
        UserDefaults.standard.set(weekDay.rawValue + 1, forKey: defaultUserDayKey)
    }
    
    static func getRequestPermissionsCounter() -> Int {
        return UserDefaults.standard.integer(forKey: requestPermissionsCounter)
    }
    
    static func increasRequestPermissionsCounter() {
        let currentValue = getRequestPermissionsCounter()
        UserDefaults.standard.set(currentValue + 1, forKey: requestPermissionsCounter)
    }
    
    static func getSavePlanCounter() -> Int {
        return UserDefaults.standard.integer(forKey: savePlanCounter)
    }
    
    static func increasSavePlanCounter() {
        let currentValue = getSavePlanCounter()
        UserDefaults.standard.set(currentValue + 1, forKey: savePlanCounter)
    }
    
    /*
     if value not in minutes range return 30 min
     */
    static func getWaterTime() -> Int {
        let minutes = UserDefaults.standard.integer(forKey: waterTime)
        
        return minutes < waterTimeRange[0] || minutes > waterTimeRange[waterTimeRange.count - 1] ? 30 : minutes
    }
    
    static func setWaterBeforeMeal(include: Bool) {
        UserDefaults.standard.set(include, forKey: waterBeforeMeal)
    }
    
    static func getWaterBeforeMeal() -> Bool {
        return UserDefaults.standard.bool(forKey: waterBeforeMeal)
    }
    
    static func setWeight(value: Double) {
        UserDefaults.standard.set(value, forKey: weight)
    }
    
    /*
     default value = 50 kg
     */
    static func getWeight() -> Double {
        let weightValue = UserDefaults.standard.double(forKey: weight)
        return weightValue == 0 ? 50 : weightValue
    }
    
    static func setDayActivity(value: Int) {
        UserDefaults.standard.set(value, forKey: dayActivity)
    }
    
    static func getDayActivity() -> Int {
        return UserDefaults.standard.integer(forKey: dayActivity)
    }
    
    static func setWaterQuantity(value: Double) {
        UserDefaults.standard.set(value, forKey: waterQuantity)
    }
    
    static func getWaterQuantity() -> Double {
        return UserDefaults.standard.double(forKey: waterQuantity)
    }
    
    /*
     possible values are 1,2
     1 - false
     2 - true
     */
    static func setCurrentSystem(isMetric: Bool) {
        if isMetric {
            UserDefaults.standard.set(2, forKey: currentSystemIsMetric)
        } else {
            UserDefaults.standard.set(1, forKey: currentSystemIsMetric)
        }
    }
    
    /*
     possible values are 0,1,2
     0 - not existing
     1 - false
     2 - true
     */
    static func isCurrentSystemMetric() -> Bool {
        let curVal = UserDefaults.standard.integer(forKey: currentSystemIsMetric)
        
        return curVal == 0 ? Locale.current.usesMetricSystem : curVal == 2 ? true : false
    }
    
    static func setCurrentDayKey(dayKey: String) {
        UserDefaults.standard.set(dayKey, forKey: currentDayKey)
    }
    
    static func getCurrentDayKey() -> String {
        return UserDefaults.standard.string(forKey: currentDayKey) ?? ""
    }
    
    static func setWaterTime(minutes: Int) {
        UserDefaults.standard.set(minutes, forKey: waterTime)
    }
    
    static func getDontAskToReview() -> Int {
        return UserDefaults.standard.integer(forKey: dontAskToReview)
    }
    
    static func increaseDontAskToReview() {
        let currentValue = getDontAskToReview()
        UserDefaults.standard.set(currentValue + 1, forKey: dontAskToReview)
    }
    
    static func getSuccessPathes() -> Int {
        return UserDefaults.standard.integer(forKey: successPathes)
    }
    
    static func increaseSuccessPath() {
        let currentValue = getSuccessPathes()
        UserDefaults.standard.set(currentValue + 1, forKey: successPathes)
    }
    
    static func getDisagreeToReview() -> Int {
        return UserDefaults.standard.integer(forKey: disagreeToReview)
    }
    
    static func increasDisagreeToReview() {
        let currentValue = getDisagreeToReview()
        UserDefaults.standard.set(currentValue + 1, forKey: disagreeToReview)
    }
    
    static func getAgreeToReview() -> Int {
        return UserDefaults.standard.integer(forKey: agreeToReview)
    }
    
    static func increasAgreeToReview() {
        let currentValue = getAgreeToReview()
        UserDefaults.standard.set(currentValue + 1, forKey: agreeToReview)
    }
}
