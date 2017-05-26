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
    var weekDay: WeekDay?
    
    func createLocalNotification() {
        if let day = weekDay {
            let dayOfWeek = WeekDays(rawValue: day.weekDay)!
            let identifier = LocalNotificationUtils.composeNotificationIdentifierFor(dayOfWeek: dayOfWeek, date: startAt)
            _ = LocalNotificationUtils.performNotificationCreationWith(title: "Test", body: description, date: startAt, identifier: identifier, dayOfWeek: dayOfWeek)
            
        } else {
            //TODO: add error handling
        }
        
    }
}
