//
//  LcoalNotificationManager.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 02/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotificationManager {
    static let dq = DispatchQueue.global(qos: .userInteractive)
    
    static func prepareLocalNotifications() {
        LocalNotificationUtils.removeAllLocalNotifications()
    }
    
    static func buildLocalNotifications() {
        print("Gonna remove all notifications and print before remove")
        LocalNotificationUtils.printPendingLocalNotifications()
        dq.async {
            let group  = DispatchGroup()
            group.enter()            
            LocalNotificationUtils.removeAllLocalNotifications()
            sleep(1)
            group.leave()
            
            let weekDays = RealmManager.getAllWeekDays()
            var timeEvents: [TimeEvent] = []
            for weekDay in weekDays {
                timeEvents.append(contentsOf: weekDay.prepareTimeEvents())
            }
            
            var notificationRequests: [UNNotificationRequest] = []
            for timeEvent in timeEvents {
                if let request = composeLocalNotificationRequest(forEvent: timeEvent) {
                    notificationRequests.append(request)
                }
            }
            
            notificationRequests.sort {
                let trigger1 = $0.trigger as! UNCalendarNotificationTrigger
                let trigger2 = $1.trigger as! UNCalendarNotificationTrigger
                
                return trigger1.nextTriggerDate()! < trigger2.nextTriggerDate()!
            }
            
            let slicedNotificationRequests = notificationRequests.prefix(upTo: notificationRequests.count > 63 ? 63 : notificationRequests.count - 1)
            
            group.notify(queue: DispatchQueue.main) { () in
                    print("Print after remove!!")
                    LocalNotificationUtils.printPendingLocalNotifications()

                
                for request in slicedNotificationRequests {
                    LocalNotificationUtils.scheduleNotificationWith(request: request)
                }
            }
            
        }
        
    }
    
    static func composeLocalNotificationRequest(forEvent timeEvent: TimeEvent) -> UNNotificationRequest? {
        var request: UNNotificationRequest? = nil
        if let day = timeEvent.weekDay {
            let dayOfWeek = WeekDays(rawValue: day.weekDay)!
            let identifier = LocalNotificationUtils.composeNotificationIdentifierFor(dayOfWeek: dayOfWeek, date: timeEvent.startAt)
            request = LocalNotificationUtils.createNotificationRequestWith(title: "Time is coming!", body: timeEvent.description, date: timeEvent.startAt, identifier: identifier, dayOfWeek: dayOfWeek)
        } else {
            //TODO: add error handling
            print("Wrong weekDay for Event with starts at \(timeEvent.startAt)")
        }
        
        return request
    }
}
