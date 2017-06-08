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
    
    /*
     Remove all notifications
     Find all week days
     Create timeEvents from days
     Delete notifications if more than 64
     Compose "Special" notification reminder for a 4 days ahead
     Add notifications to the center
     */
    static func buildLocalNotifications() {
        print("Gonna remove all notifications and print before remove")
        LocalNotificationUtils.printPendingLocalNotifications()
        dq.async {
            let group  = DispatchGroup()
            group.enter()            
            LocalNotificationUtils.removeAllPendingLocalNotifications()
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
            
            notificationRequests.append(composeSpecialReminderNotificationRequest())
            
            notificationRequests.sort {
                let trigger1 = $0.trigger as! UNCalendarNotificationTrigger
                let trigger2 = $1.trigger as! UNCalendarNotificationTrigger
                
                return trigger1.nextTriggerDate()! < trigger2.nextTriggerDate()!
            }
            
            let slicedNotificationRequests = notificationRequests.prefix(upTo: notificationRequests.count > 63 ? 63 : notificationRequests.count)
            
            group.notify(queue: DispatchQueue.main) { () in
                    print("Print after remove!!")
                    LocalNotificationUtils.printPendingLocalNotifications()

                
                for request in slicedNotificationRequests {
                    LocalNotificationUtils.scheduleNotificationWith(request: request)
                }
            }
            
        }
        
    }
    
    /*
     Special reminder for 3 days ahead about openning an app for further notifications
     */
    static func composeSpecialReminderNotificationRequest() -> UNNotificationRequest {
        let date = Date().nine
        let weekDay = DateTimeUtils.getCurrentWeekDayNumber()
        let ahead3Days = (weekDay.rawValue + 3) > 6 ? (weekDay.rawValue + 3) % 7 : (weekDay.rawValue + 3)
        
        let formatter = DateFormatter()
        formatter.dateFormat = ":HH:mm"
        let hourMinutes =  formatter.string(from: date)
        
        let identifier = specialNotificationReminder + String(ahead3Days) + hourMinutes
        let request = LocalNotificationUtils.createNotificationRequestWith(title: "Still with us?", body: "Always stay informed about your next meal. Just reopen the app so we can produce for you new meal reminders", date: date, identifier: identifier, dayOfWeek: WeekDays(rawValue: ahead3Days)!)
        
        return request
    }
    
    /*
     Compose notififcation request for exact time event
     */
    static func composeLocalNotificationRequest(forEvent timeEvent: TimeEvent) -> UNNotificationRequest? {
        var request: UNNotificationRequest? = nil
        if let day = timeEvent.weekDay {
            let dayOfWeek = WeekDays(rawValue: day.weekDay)!
            let identifier = LocalNotificationUtils.composeNotificationIdentifierFor(dayOfWeek: dayOfWeek, date: timeEvent.startAt)
            request = LocalNotificationUtils.createNotificationRequestWith(title: "The time has come :)", body: timeEvent.notificationDescription, date: timeEvent.startAt, identifier: identifier, dayOfWeek: dayOfWeek)
        } else {
            //TODO: add error handling
            print("Wrong weekDay for Event with starts at \(timeEvent.startAt)")
        }
        
        return request
    }
}
