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
    
    static func getWaterTime() -> Int {
        let minutes = UserDefaults.standard.integer(forKey: waterTime)
        
        return minutes < waterTimeRange[0] || minutes > waterTimeRange[waterTimeRange.count - 1] ? 30 : minutes
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
