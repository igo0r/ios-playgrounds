//
//  WeekDay.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 07/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import RealmSwift

class WeekDay: Object {
    dynamic var weekDay = 0
    dynamic var wakeUpAt = NSDate()
    dynamic var sleepAt = NSDate()
    dynamic var withWater = false
    dynamic var mealsCount = 3
    
    override static func primaryKey() -> String? {
        return "weekDay"
    }

    
    func getWakeUpAt() -> Date {
        return wakeUpAt as Date
    }
    
    func getSleepAt() -> Date {
        return sleepAt as Date
    }
    
    override static func ignoredProperties() -> [String] {
        return ["tmpID"]
    }
    
    func prepareTimeEvents(_ withProgress: Bool = false) -> [TimeEvent] {
        var wakeUpAt = getWakeUpAt()
        var events = [TimeEvent]()
        
        let sleepAt = getSleepAt()
        let waterTime = TimeInterval(60 * UserDefaultsUtils.getWaterTime())
        
        let waterDescription = "Water time!\n Swipe or press to confirm the action"
        
        if self.withWater {
            events.append(TimeEvent(startAt: wakeUpAt, description: "Water time!", notificationDescription: waterDescription, weekDay: self))
            events.append(TimeEvent(startAt: sleepAt.addingTimeInterval(-waterTime), description: "Water time!", notificationDescription: waterDescription, weekDay: self))
            wakeUpAt = wakeUpAt.addingTimeInterval(waterTime)
        }
        
        let difference = sleepAt.timeIntervalSince(wakeUpAt)
        let stepBetweenMeals = Int(difference) / mealsCount
        
        for counter in 0..<mealsCount {
            let currentInterval = TimeInterval(counter * stepBetweenMeals)
            let mealTime = wakeUpAt.addingTimeInterval(currentInterval)
            events.append(TimeEvent(startAt: mealTime, description: "\(counter + 1) meal", notificationDescription: "Take your \(counter + 1) meal. Bon appetit! \n Swipe or press to confirm the action", weekDay: self))
            
            if withWater && counter > 0 {
                let waterTime = wakeUpAt.addingTimeInterval(currentInterval - waterTime)
                events.append(TimeEvent(startAt: waterTime, description: "Water time!", notificationDescription: waterDescription, weekDay: self))
            }
        }
        
        events.append(TimeEvent(startAt: sleepAt, description: "Time to go to bed!", notificationDescription: "Its time to go to bed!\n Swipe or press to confirm the action", weekDay: self))
        events.sort(by: {$0.startAt < $1.startAt})
        
        if WeekDays(rawValue: weekDay) == DateTimeUtils.getCurrentWeekDayNumber() && withProgress {
            events = prepareProgressTimeForToday(events: events)
        }
        
        return events
    }
    
    func createLocalNotificationsForCurrentDay() {
        let events = prepareTimeEvents()
        for event in events {
            event.createLocalNotification()
        }
       // LocalNotificationUtils.printPendingLocalNotifications()
    }
    
    func deleteLocalNotificationsForCurrentDay() {
        let identifier = LocalNotificationUtils.composeNotificationIdentifierFor(dayOfWeek: WeekDays(rawValue: weekDay)!, date: nil)
        LocalNotificationUtils.removeLocalNotificationsWith(identifier: identifier)
    }
    
    /*
     returns timeevents with
     */
    func prepareProgressTimeForToday(events: [TimeEvent]) -> [TimeEvent] {
        var events = events
        for (index, _) in events.enumerated() {
            let previousEventTime = index == 0 ? DateTimeUtils.currentDate.noon : events[index - 1].startAt
            let currentEventTime = events[index].startAt
            let intervalFromNowToCurrentEvent = DateTimeUtils.currentDate.timeIntervalSince(currentEventTime)
            let intervalFromNowToPreviousEvent = DateTimeUtils.currentDate.timeIntervalSince(previousEventTime)
            if intervalFromNowToPreviousEvent > 0 && intervalFromNowToCurrentEvent <= 0 {
                let timeInterval = currentEventTime.timeIntervalSince(previousEventTime)
                let progressIndex = progressViewMaxValue / timeInterval
                events[index].progressTime = progressIndex * intervalFromNowToPreviousEvent
            }
            else if intervalFromNowToCurrentEvent < 0 {
                events[index].progressTime = 1
            }
            else if intervalFromNowToCurrentEvent > 0 {
                events[index].progressTime = progressViewMaxValue
            }
        }
        
        return events
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
