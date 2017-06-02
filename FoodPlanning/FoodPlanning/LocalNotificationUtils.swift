//
//  LocalNotificationUtils.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 22/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationUtils {
    static let notificationCenter = UNUserNotificationCenter.current()
    static let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    static func askNotificationPermissions() {
        notificationCenter.requestAuthorization(options: options) {
            (granted, error) in
        }
    }
    
    static func isAuthorized() -> Bool {
        var isAuth = false
        notificationCenter.getNotificationSettings { (settings) in
            isAuth = settings.authorizationStatus != .authorized
        }
        
        return isAuth
    }
    
    static func performNotificationCreationWith(title: String, body: String, date: Date, identifier: String, dayOfWeek: WeekDays) {
        let request = createNotificationRequestWith(title: title, body: body, date: date, identifier: identifier, dayOfWeek: dayOfWeek)
        scheduleNotificationWith(request: request)
    }
    
    static func createNotificationRequestWith(title: String, body: String, date: Date, identifier: String, dayOfWeek: WeekDays) -> UNNotificationRequest {
        let content = createNotificationWith(title: title, body: body)
        let trigger = createCalendarTrigerFor(date: date, dayOfWeek: dayOfWeek)
        
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    static func createNotificationWith(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = okNotificationCategory
        
        return content
    }
    
    static func createCalendarTrigerFor(date: Date, dayOfWeek: WeekDays) -> UNCalendarNotificationTrigger {
        var triggerWeekly = DateTimeUtils.currentCalendar.dateComponents([.weekday,.hour,.minute,.second], from: date)
        triggerWeekly.weekday = DateTimeUtils.weekDayFormaterFromMonToSun(weekDay: dayOfWeek.rawValue + 2)
        triggerWeekly.second = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly,                                             repeats: true)
        
        return trigger
    }
    
    static func scheduleNotificationWith(request: UNNotificationRequest) {
        //removeFarthestNotificationIfNeeded (forRequest: request) { () in
            notificationCenter.add(request) { (error) in
                if let error = error {
                    print("Add request ERROR! \(error)")
                    //TODO: Add logger action
                } else {
                    print("Added identifier: \(request.identifier)")
                }
            }
        //}
    }
    
    static func composeNotificationIdentifierFor(dayOfWeek: WeekDays, date: Date?) -> String {
        var str = eventNotificationKey + String(dayOfWeek.rawValue)
        if let date = date {
            let formatter = DateFormatter()
            formatter.dateFormat = ":HH:mm"
            let hourMinutes =  formatter.string(from: date)
            
            str = str + hourMinutes
        }
        
        return str
    }
    
    static func removeLocalNotificationsWith(identifier: String) {
        notificationCenter.getPendingNotificationRequests { (requests) in
            var identifiers = [String]()
            for request in requests {
                let identif = request.identifier
                print("Existing identifier is \(identif)")
                if identif.contains(identifier) {
                    
                    identifiers.append(identif)
                }
            }
            print("Identifiers to remove: \(identifiers)")
            notificationCenter.removePendingNotificationRequests(withIdentifiers: identifiers)
            notificationCenter.removeDeliveredNotifications(withIdentifiers: identifiers)
        }
    }
    
    static func removeAllLocalNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    /*
     Remove notifications for 0 - monday .. 6 - sunday
     */
    static func removeLocalNotificationsFor(dayOfWeek: WeekDays) {
        let identifier = composeNotificationIdentifierFor(dayOfWeek: dayOfWeek, date: nil)
        removeLocalNotificationsWith(identifier: identifier)
    }
    
    static func removeFarthestNotificationIfNeeded(forRequest request: UNNotificationRequest, completionHandler: @escaping () -> ()) {
        if let trigger = request.trigger as? UNCalendarNotificationTrigger {
            if let newNotificationDate = trigger.nextTriggerDate() {
                getFarthestNotificationWithCount(fromDate: Date()) { (identifier, notificationsCount, existNotificationDate) in
                    print("TRY to REMOVE!count \(notificationsCount) exist \(existNotificationDate) new \(newNotificationDate)")
                    if notificationsCount > 50 {
                        if let notificationIdentifier = identifier {
                            if let existNotificationDate = existNotificationDate {
                                if newNotificationDate <= existNotificationDate {
                                    print("GONNA to REMOVE farthest \(notificationIdentifier)")
                                    notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
                                    waitTillLocalNotificationGone(withIdentifier: notificationIdentifier) {
                                        completionHandler()
                                    }
                                }
                            }

                        }
                    } else {
                        completionHandler()
                    }
                    
                }
            }
        }
    }
    
    /*
     Get the farthest from now
     */
    static func getFarthestNotificationWithCount(fromDate: Date = Date(), completionHandler: @escaping (String?, Int, Date?) -> ()) {
        var farthestNotification: String? = nil
        var notificationDate: Date? = nil
        var diff = 0
        var notificationsCount = 0
        notificationCenter.getPendingNotificationRequests { (requests) in
            notificationsCount = requests.count
            for request in requests {
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    if let date = trigger.nextTriggerDate() {
                        let difference = date.seconds(fromDate: fromDate)
                        if difference > diff {
                            diff = difference
                            farthestNotification = request.identifier
                            notificationDate = date
                        }
                    }
                }
            }
            completionHandler(farthestNotification, notificationsCount, notificationDate)
        }
    }
    
    static func waitTillLocalNotificationGone(withIdentifier identifier: String, completionHandler: @escaping () -> ()) {
        notificationCenter.getPendingNotificationRequests { (requests) in
            for request in requests {
                
                if request.identifier == identifier {
                    waitTillLocalNotificationGone(withIdentifier: identifier) {}
                    return
                }
            }
            completionHandler()
        }
    }
    
    static func printPendingLocalNotifications() {
        notificationCenter.getPendingNotificationRequests { (requests) in
            for request in requests {
                let identif = request.identifier
                print("||=> Existing identifier is \(identif)")
            }
        }
    }
    
    static func printDeliveredLocalNotifications() {
        notificationCenter.getDeliveredNotifications { (requests) in
            for request in requests {
                let identif = request.date
                print("||=> Delivered identifier is \(identif)")
            }
        }
    }
    
}
