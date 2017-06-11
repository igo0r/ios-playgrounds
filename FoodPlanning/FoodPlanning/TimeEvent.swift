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
    
    /*From 0 to 1 used for progressView*/
    var progressTime: Double = 0
    
    init(startAt: Date, description: String, notificationDescription: String, weekDay: WeekDay?) {
        self.startAt = startAt
        self.description = description
        self.notificationDescription = notificationDescription
        self.weekDay = weekDay
    }
    
    func createLocalNotification() {
        if let day = weekDay {
            let dayOfWeek = WeekDays(rawValue: day.weekDay)!
            let identifier = LocalNotificationUtils.composeNotificationIdentifierFor(dayOfWeek: dayOfWeek, date: startAt)
            LocalNotificationUtils.performNotificationCreationWith(title: "Test", body: description, date: startAt, identifier: identifier, dayOfWeek: dayOfWeek)            
        } else {
            //TODO: add error handling
            print("Wrong weekDay for Event with starts at \(startAt)")
        }
    }
}
