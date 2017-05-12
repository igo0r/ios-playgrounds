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
     Starts from 1 to 7
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
}
