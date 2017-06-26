//
//  DateTimeUtils.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class DateTimeUtils {
    
    static var currentDate: Date {
        return Date()
    }

    static var now: Date {
        return Date()
    }
    static var currentWeek = [WeekDays:Date]()
    static var currentCalendar = Calendar.current
    
    /*
     Array from 1 to 7
     */
    static func getCurrentWeek() -> [WeekDays:Date] {
        if !currentWeek.isEmpty {
            return currentWeek
        }
        
        var calendar = currentCalendar
        let today = getCurrentDate()
        var dayOfWeek = calendar.component(.weekday, from: today) - (calendar.firstWeekday - 1)
        dayOfWeek = weekDayFormaterFromSunToMon(weekDay: dayOfWeek)
        
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        
        for index in (weekdays.lowerBound ..< weekdays.upperBound) {
            if let date = calendar.date(byAdding: .day, value: index - dayOfWeek, to: today) {
                let currentOriginWeekNumber = calendar.component(.weekday, from: date) - 2
                if let weekDay = WeekDays(rawValue: currentOriginWeekNumber < 0 ? 6 : currentOriginWeekNumber) {
                    currentWeek[weekDay] = date
                }
            }
        }
        
        return currentWeek
    }
    
    /*
     checks if CurrentDayKey belongs to the current date
     for situation when app opens too long and its new day already
     */
    static func isCurrentDateKeyValid(withUpdateDateKey: Bool = true) -> Bool {
        let currentStr = composeCurrentDayKey()
        let userDefaultStr = UserDefaultsUtils.getCurrentDayKey()
        
        if currentStr != userDefaultStr {
            UserDefaultsUtils.setCurrentDayKey(dayKey: currentStr)
            
            return false
        }
        
        return true
    }
    
    /*
     set user default current date key
     */
    static func updateCurrentDateKey() {
        UserDefaultsUtils.setCurrentDayKey(dayKey: composeCurrentDayKey())
    }
    
    /*
     returns current dat ein format yyyy-mm-dd
     */
    static func composeCurrentDayKey() -> String {
        let date = currentDate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy:MM:dd"
        
        return formatter.string(from: date)
    }
    
    /*
     Starts from 0 = Monday
     */
    static func getCurrentWeekDayNumber() -> WeekDays {
        let today = getCurrentDate()
        let dayOfWeek = currentCalendar.component(.weekday, from: today) - 2

        return WeekDays(rawValue: dayOfWeek < 0 ? 6 : dayOfWeek)!
    }
    
    static func isTimeIntervalLess(than interval: Double, betweenDate1 date1: Date, andDate2 date2: Date) -> Bool {
        return date1.timeIntervalSince(date2) <= interval
    }
    
    static func getCurrentDate() -> Date {
        return currentDate
    }
    
    /*
     from btn tag to WeekDays take into account firstDayOfWeek
     */
    static func routeFromDayTagToWeekDays(btnTag: Int) -> WeekDays {
        let (start, _) = getWeekStartEndAsWeekDays()
        var finalWeekDay = start
        var counter = 0
        while counter != btnTag {
            let rawVal = finalWeekDay.rawValue + 1
            finalWeekDay = WeekDays(rawValue: rawVal > 6 ? 0 : rawVal)!
            counter = counter + 1
        }
        
        return finalWeekDay
    }
    
    /*
     return first and last week day as WeekDays
     */
    static func getWeekStartEndAsWeekDays() -> (WeekDays, WeekDays) {
        let index = currentCalendar.firstWeekday - 2
        let start = WeekDays(rawValue: weekDayFormaterLessZerro(weekDay: index))!
        let end = WeekDays(rawValue: weekDayFormaterLessZerro(weekDay: start.rawValue - 1))!
        return (start, end)
    }
    
    /*
     weekDay = -1...5
     return 0...6
     */
    static func weekDayFormaterLessZerro(weekDay: Int) -> Int {
        return weekDay < 0 ? 6 : weekDay
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
        return weekDay < 1 ? 7 + weekDay : weekDay
    }
    
    static func startOfToday() -> Date {
        return currentCalendar.startOfDay(for: currentDate)
    }

}
