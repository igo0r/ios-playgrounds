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

class LocalNotificationClass {
    let dq = DispatchQueue(label: "com.FoodPlannerApp")
    
    /*
     Remove all notifications
     Find all week days
     Create timeEvents from days
     Delete notifications if more than 64
     Compose "Special" notification reminder for a 4 days ahead
     Add notifications to the center
     */
    func buildLocalNotifications() {
        print("Gonna remove all notifications and print before remove")
        LocalNotificationUtils.printPendingLocalNotifications()
        let taskManager = BackgroundTaskManager(withName: "LocalNotifications")
        taskManager.doBackgroundTask() { (cH) in
            let group  = DispatchGroup()
            group.enter()
            LocalNotificationUtils.removeAllPendingLocalNotifications()
            group.leave()

            let weekDays = WeekDayRealmManager.getAllWeekDaysSorted()
            var timeEvents: [TimeEvent] = []
            for weekDay in weekDays {
                timeEvents.append(contentsOf: weekDay.prepareEvents())
            }
            var notificationRequests: [UNNotificationRequest] = []
            var todayPastNotificationRequests: [UNNotificationRequest] = []
            for timeEvent in timeEvents {
                if let request = self.composeLocalNotificationRequest(forEvent: timeEvent) {
                    if timeEvent.isToday() && timeEvent.isTodayInThePast() {
                        todayPastNotificationRequests.append(request)
                    } else {
                        notificationRequests.append(request)
                    }
                }
            }
            notificationRequests = notificationRequests + todayPastNotificationRequests
            notificationRequests.insert(self.composeSpecialReminderNotificationRequest(), at: 0)
            
            let slicedNotificationRequests = notificationRequests.prefix(upTo: notificationRequests.count > 63 ? 63 : notificationRequests.count)
            
            group.notify(queue: self.dq) { () in
                print("Print after remove!!")
                let notificationGroup  = DispatchGroup()
                for request in slicedNotificationRequests {
                    notificationGroup.enter()
                    LocalNotificationUtils.scheduleNotificationWith(request: request) {
                        notificationGroup.leave()
                    }
                }
                notificationGroup.notify(queue: self.dq) { () in
                    cH()
                }
            }
        }
    }
    
    /*
     Special reminder for 3 days ahead about openning an app for further notifications
     */
    func composeSpecialReminderNotificationRequest() -> UNNotificationRequest {
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
    func composeLocalNotificationRequest(forEvent timeEvent: TimeEvent) -> UNNotificationRequest? {
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
