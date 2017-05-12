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
    dynamic var mealsCount = 0
    
    func getWakeUpAt() -> Date {
        return wakeUpAt as Date
    }
    
    func getSleepAt() -> Date {
        return sleepAt as Date
    }
    
    func prepareTimeEvents() -> [TimeEvent] {
        var wakeUpAt = getWakeUpAt()
        var events = [TimeEvent]()
        
        let sleepAt = getSleepAt()
        let halfAnHour = TimeInterval(60 * 30)
        
        if self.withWater {
            events.append(TimeEvent(startAt: wakeUpAt, description: "Water time!"))
            events.append(TimeEvent(startAt: sleepAt.addingTimeInterval(-halfAnHour), description: "Water time!"))
            wakeUpAt = wakeUpAt.addingTimeInterval(halfAnHour)
        }
        
        let difference = sleepAt.timeIntervalSince(wakeUpAt)
        let stepBetweenMeals = Int(difference) / mealsCount
        
        for counter in 0..<mealsCount {
            let currentInterval = TimeInterval(counter * stepBetweenMeals)
            let mealTime = wakeUpAt.addingTimeInterval(currentInterval)
            events.append(TimeEvent(startAt: mealTime, description: "Enjoy your \(counter + 1) meal!"))
            
            if withWater && counter > 0 {
                let waterTime = wakeUpAt.addingTimeInterval(currentInterval - halfAnHour)
                events.append(TimeEvent(startAt: waterTime, description: "Water time!"))
            }
        }
        
        events.append(TimeEvent(startAt: sleepAt, description: "Its time to go to bed!"))
        events.sort(by: {$0.startAt < $1.startAt})
        
        return events
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
