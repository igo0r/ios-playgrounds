//
//  Date.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 23/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

extension Date {
    var yesterday: Date {
        return DateTimeUtils.currentCalendar.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return DateTimeUtils.currentCalendar.date(byAdding: .day, value: 1, to: self)!
    }
    var noon: Date {
        return DateTimeUtils.currentCalendar.date(bySettingHour: 0, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return DateTimeUtils.currentCalendar.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    func addingTimeIntervalNotBiggerThanTomorrow(_ interval: TimeInterval) -> Date {
        let tomorrowNoon = self.tomorrow.noon
        var newDate = self.addingTimeInterval(secondsFrom13Hours)
        if newDate >= tomorrowNoon {
            newDate = tomorrowNoon.addingTimeInterval(-1)
        }
        
        return newDate
    }
}
