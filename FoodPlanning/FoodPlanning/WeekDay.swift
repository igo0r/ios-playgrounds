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
    let recurrentEvents = LinkingObjects(fromType: RecurrentEvent.self, property: "weekDay")
    
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
    
    /*
     needs for migration water settings from day form to standalone tab bar
     */
    func transformNewWaterFormat() {
        WeekDayRealmManager.updateWeekDayWaterSettingsWith(obj: self, value: false)
        UserDefaultsUtils.setWaterBeforeMeal(include: true)
    }
    
    /*
     migrate from weekdays to recurrent events + weekdays
     create recurrent events if needed
     return timeevents
     */
    func prepareEvents(_ withProgress: Bool = false) -> [TimeEvent] {
        var timeEvents = TimeEventRealmManager.loadTimeEventsFor(weekDay: self)
        if timeEvents.count == 0 {
            timeEvents = prepareTimeEvents()
            TimeEventRealmManager.writeTimeEvents(objs: timeEvents)
        }
        
        timeEvents = prepareProgressTimeFor(events: timeEvents, withProgress: withProgress)
        return timeEvents
    }
    
    /*
     calculate dose of water
     create water notifications if necessary 
     take meals count and divide it from start to the end
     
     returns array of TimeEvent
     */
    func prepareTimeEvents(_ withProgress: Bool = false) -> [TimeEvent] {
        var wakeUpAt = getWakeUpAt()
        var events = [TimeEvent]()
        
        let sleepAt = getSleepAt()
        let waterTime = TimeInterval(60 * UserDefaultsUtils.getWaterTime())
        
        let waterCalculator = WaterCalculator()
        let waterPortion = waterCalculator.divideWaterQuantityFor(times: mealsCount+1)
        let waterNotificationDescription = "Water time!\nDrink \(waterPortion) \(waterCalculator.getWaterLblTxt()) of water."
        let waterDescription = "Water drink \(waterPortion) \(waterCalculator.getWaterLblTxt())"
        
        if self.withWater {
            transformNewWaterFormat()
        }
        if UserDefaultsUtils.getWaterBeforeMeal() {
            events.append(TimeEvent(startAt: wakeUpAt, description: waterDescription, notificationDescription: waterNotificationDescription, weekDay: self))
            events.append(TimeEvent(startAt: sleepAt.addingTimeInterval(-waterTime), description: waterDescription, notificationDescription: waterNotificationDescription, weekDay: self))
            wakeUpAt = wakeUpAt.addingTimeInterval(waterTime)
        }
        
        let difference = sleepAt.timeIntervalSince(wakeUpAt)
        let stepBetweenMeals = Int(difference) / mealsCount
        
        for counter in 0..<mealsCount {
            let currentInterval = TimeInterval(counter * stepBetweenMeals)
            let mealTime = wakeUpAt.addingTimeInterval(currentInterval)
            events.append(TimeEvent(startAt: mealTime, description: "\(counter + 1) meal", notificationDescription: "Take your \(counter + 1) meal. Bon appetit!", weekDay: self))
            
            if UserDefaultsUtils.getWaterBeforeMeal() && counter > 0 {
                let waterTime = wakeUpAt.addingTimeInterval(currentInterval - waterTime)
                events.append(TimeEvent(startAt: waterTime, description: waterDescription, notificationDescription: waterNotificationDescription, weekDay: self))
            }
        }
        
        events.append(TimeEvent(startAt: sleepAt, description: "Time to go to bed!", notificationDescription: "Good night!", weekDay: self))
        events.sort(by: {$0.startAt < $1.startAt})
        events = prepareProgressTimeFor(events: events, withProgress: withProgress)
        
        return events
    }

    /*
     returns timeevents with progress from 0 to 1
     1 for passed
     0 for comming
     and 0..1 for current event
     */
    func prepareProgressTimeFor(events: [TimeEvent], withProgress: Bool) -> [TimeEvent] {
        if WeekDays(rawValue: weekDay) != DateTimeUtils.getCurrentWeekDayNumber() || !withProgress {
            return events
        }
        var events = events
        for (index, _) in events.enumerated() {
            let previousEventTime = index == 0 ? DateTimeUtils.startOfToday() : events[index - 1].startAt.transformToCurrentDate()
            let currentEventTime = events[index].startAt.transformToCurrentDate()
            let intervalFromNowToCurrentEvent = DateTimeUtils.now.timeIntervalSince(currentEventTime)
            let intervalFromNowToPreviousEvent = DateTimeUtils.now.timeIntervalSince(previousEventTime)
            if intervalFromNowToPreviousEvent > 0 && intervalFromNowToCurrentEvent <= 0 {
                events[index].progressTime = intervalFromNowToCurrentEvent
            }
            else if intervalFromNowToCurrentEvent < 0 {
                events[index].progressTime = 0
            }
            else if intervalFromNowToCurrentEvent > 0 {
                events[index].progressTime = progressViewMaxValue
            }
        }
        
        return events
    }
}
