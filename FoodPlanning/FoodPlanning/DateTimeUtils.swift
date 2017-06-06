//
//  DateTimeUtils.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class DateTimeUtils {
    
    //static let firstWeekday = 1
    static let currentDate = Date()
    static var currentWeek = [Date]()
    static var currentCalendar = Calendar.current
    
    /*
     Array from 1 to 7
     */
    static func getCurrentWeek() -> [Date] {
        if !currentWeek.isEmpty {
            return currentWeek
        }
        
        var calendar = currentCalendar
        //calendar.firstWeekday = firstWeekday
        
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
        var calendar = currentCalendar
        //calendar.firstWeekday = firstWeekday
        let today = getCurrentDate()
        var dayOfWeek = calendar.component(.weekday, from: today) - (calendar.firstWeekday - 1)
        dayOfWeek = weekDayFormaterFromSunToMon(weekDay: dayOfWeek)

        return WeekDays(rawValue: (dayOfWeek - 1))!
    }
    
    static func isTimeIntervalLess(than interval: Double, betweenDate1 date1: Date, andDate2 date2: Date) -> Bool {
        return date1.timeIntervalSince(date2) <= interval
    }
    
    static func getCurrentDate() -> Date {
        return currentDate
    }
    
    /*
     weekDay = 1...7
     return 0...6
     */
    static func weekDayFormaterFromMonToSun(weekDay: Int) -> Int {
        return weekDay > 7 ? 1 : weekDay
    }
    
    /*
     weekDay = 0...6
     return 1...7
     */
    static func weekDayFormaterFromSunToMon(weekDay: Int) -> Int {
        return weekDay < 1 ? 7 : weekDay
    }
    
    static func getTomorrowNoon() {
        
    }

}
