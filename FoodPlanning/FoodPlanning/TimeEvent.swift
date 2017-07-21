//
//  TimeEvent.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 04/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

struct TimeEvent {
    var startAt = Date()
    var description = ""
    var notificationDescription = ""
    var weekDay: WeekDay?
    var recurrentEvent: RecurrentEvent?
    
    /*From 0 to 1 used for progressView*/
    var progressTime: Double = 0
    
    init(startAt: Date, description: String, notificationDescription: String, weekDay: WeekDay?) {
        self.startAt = startAt
        self.description = description
        self.notificationDescription = notificationDescription
        self.weekDay = weekDay
    }
    
    /*
     Is timeevent from today
     */
    func isToday() -> Bool {
        if let day = weekDay {
            return WeekDays(rawValue: day.weekDay)! == DateTimeUtils.getCurrentWeekDayNumber()
        }
        return false
    }
    
    /*
     is timeEvent from today in the past.
     f.e. now 10 am, but event at 9
     */
    func isTodayInThePast() -> Bool {
        if let day = weekDay {
            let dayOfWeek = WeekDays(rawValue: day.weekDay)!
            if dayOfWeek == DateTimeUtils.getCurrentWeekDayNumber() {
        
                return startAt.transformToCurrentDate() < DateTimeUtils.now
            }
        }
        return false
    }
    
    /*
     create recurrent event from current event
     */
    mutating func createReccurentEvent() -> RecurrentEvent {
        let recurrentEvent = RecurrentEvent()
        recurrentEvent.startAt = startAt as NSDate
        recurrentEvent.descriptionText = description
        recurrentEvent.weekDay = weekDay ?? nil
        
        self.recurrentEvent = recurrentEvent
        return recurrentEvent
    }
}
