//
//  LocalNotificationUtils.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 22/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotificationUtils {
    static let notificationCenter = UNUserNotificationCenter.current()
    static let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    /*
     Open appliation settings
     */
    static func openAppSettings() {
        if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }
    
    /*
     Ask first time about permissions
     */
    static func askNotificationPermissions(cH: @escaping (Bool) -> ()) {
        notificationCenter.requestAuthorization(options: options) {
            (granted, error) in
            cH(granted)
        }
    }
    
    /*
     Ask first time about permissions
     */
    static func askNotificationPermissions() {
        notificationCenter.requestAuthorization(options: options) {
            (granted, error) in
        }
    }
    
    /*
     return is app auth to send notifications
     */
    static func isAuthorizedToSendNotifications(cH: @escaping (Bool) -> ()) {
        notificationCenter.getNotificationSettings { (settings) in
            cH(settings.authorizationStatus == .authorized)
        }
    }
    
    /*
     create and add to center full notififxation with content and trigger
     */
    static func performNotificationCreationWith(title: String, body: String, date: Date, identifier: String, dayOfWeek: WeekDays) {
        let request = createNotificationRequestWith(title: title, body: body, date: date, identifier: identifier, dayOfWeek: dayOfWeek)
        scheduleNotificationWith(request: request)
    }
    
    /*
     Create and returen notificatin request
     */
    static func createNotificationRequestWith(title: String, body: String, date: Date, identifier: String, dayOfWeek: WeekDays) -> UNNotificationRequest {
        let content = createNotificationWith(title: title, body: body)
        let trigger = createCalendarTrigerFor(date: date, dayOfWeek: dayOfWeek)
        
        return UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    }
    
    /*
     Create notification content
     */
    static func createNotificationWith(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = okNotificationCategory
        
        return content
    }
    
    /*
     Date - takes hour and minutes, dayOfWeek 0...6 - compose repeat trigger for week day
     */
    static func createCalendarTrigerFor(date: Date, dayOfWeek: WeekDays) -> UNCalendarNotificationTrigger {
        var triggerWeekly = DateTimeUtils.currentCalendar.dateComponents([.weekday,.hour,.minute,.second], from: date)
        triggerWeekly.weekday = DateTimeUtils.weekDayFormaterFromMonToSun(weekDay: dayOfWeek.rawValue + 2)
        triggerWeekly.second = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly,                                             repeats: true)
        
        return trigger
    }
    
    /*
     add request to notification center
     */
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
    
    /*
     Format eventNotificationKey + week day 0..6 + HH:mm or without it
     */
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
    
    /*
     Remove notification with exact identifier
     */
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
    
    /*
     Remove all existing pending notifications
     */
    static func removeAllPendingLocalNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    /*
     Remove notifications for 0 - monday .. 6 - sunday
     */
    static func removeLocalNotificationsFor(dayOfWeek: WeekDays) {
        let identifier = composeNotificationIdentifierFor(dayOfWeek: dayOfWeek, date: nil)
        removeLocalNotificationsWith(identifier: identifier)
    }
    
    /*
     Print all pending notifications
     */
    static func printPendingLocalNotifications() {
        notificationCenter.getPendingNotificationRequests { (requests) in
            for request in requests {
                let identif = request.identifier
                print("||=> Existing identifier is \(identif)")
            }
        }
    }
    
    /*
     Print all delivered notifications
     */
    static func printDeliveredLocalNotifications() {
        notificationCenter.getDeliveredNotifications { (requests) in
            for request in requests {
                let identif = request.date
                print("||=> Delivered identifier is \(identif)")
            }
        }
    }
    
}
