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
    var nine: Date {
        return DateTimeUtils.currentCalendar.date(bySettingHour: 9, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return DateTimeUtils.currentCalendar.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date.nine, to: self.nine).day ?? 0
    }
    
    /*
     from "anyday 9:30" to "today 9:30"
     */
    func transformToCurrentDate() -> Date {
        let daysDiff = self.days(from: DateTimeUtils.currentDate)
        return DateTimeUtils.currentCalendar.date(byAdding: .day, value: -daysDiff, to: self)!
    }
    
    /// Returns the amount of seconds from another date
    func seconds(fromDate date: Date) -> Int {
        return DateTimeUtils.currentCalendar.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /*
     add 13 hours to the current time but check that its not more than tomorrow 
     */
    func addingTimeIntervalNotBiggerThanTomorrow(_ interval: TimeInterval) -> Date {
        let tomorrowNoon = self.tomorrow.noon
        var newDate = self.addingTimeInterval(secondsFrom13Hours)
        if newDate >= tomorrowNoon {
            newDate = tomorrowNoon.addingTimeInterval(-1)
        }
        
        return newDate
    }
}
