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
    
    static func performNotificationCreationWith(title: String, body: String, date: Date, identifier: String, dayOfWeek: WeekDays) -> Bool {
        let content = createNotificationWith(title: title, body: body)
        let trigger = createCalendarTrigerFor(date: date, dayOfWeek: dayOfWeek)
        return scheduleNotificationWith(identifier: identifier, content: content, trigger: trigger)
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
    
    static func scheduleNotificationWith(identifier: String, content: UNMutableNotificationContent, trigger: UNCalendarNotificationTrigger) -> Bool {
        var isSuccess = false
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: { (error) in
            print("Added identifier: \(request.identifier)")
            if let error = error {
                print("Add request ERROR! \(error)")
                //TODO: Add logger action
                isSuccess = false
            }
        })
        
        return isSuccess
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
        }
    }
    
    static func removeLocalNotificationsFor(dayOfWeek: WeekDays) {
        let identifier = composeNotificationIdentifierFor(dayOfWeek: dayOfWeek, date: nil)
        removeLocalNotificationsWith(identifier: identifier)
    }
    
}
