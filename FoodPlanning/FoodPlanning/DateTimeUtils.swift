//
//  DateTimeUtils.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class DateTimeUtils {
    
    static let firstWeekday = 2
    static let currentDate = Date()
    static var currentWeek = [Date]()
    
    static func getCurrentWeek() -> [Date] {
        if !currentWeek.isEmpty {
            return currentWeek
        }
        
        var calendar = Calendar.current
        calendar.firstWeekday = firstWeekday
        
        let today = getCurrentDate()
        var dayOfWeek = calendar.component(.weekday, from: today) - (calendar.firstWeekday - 1)
        if dayOfWeek < 1 {
            dayOfWeek = 7
        }
        
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        
        currentWeek = (weekdays.lowerBound ..< weekdays.upperBound)
            .flatMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
        
        return currentWeek
    }
    
    /*
     Starts from 0 = Monday
     */
    static func getCurrentWeekDayNumber() -> WeekDays {
        var calendar = Calendar.current
        calendar.firstWeekday = firstWeekday
        let today = getCurrentDate()
        var dayOfWeek = calendar.component(.weekday, from: today) - (calendar.firstWeekday - 1)
        if dayOfWeek < 1 {
            dayOfWeek = 7
        }

        return WeekDays(rawValue: (dayOfWeek - 1))!
    }
    
    static func isTimeIntervalLess(than interval: Double, betweenDate1 date1: Date, andDate2 date2: Date) -> Bool {
        return date1.timeIntervalSince(date2) <= interval
    }
    
    static func getCurrentDate() -> Date {
        return currentDate
    }
    
    static func getTomorrowNoon() {
        
    }

}
