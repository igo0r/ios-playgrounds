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
    
    static func createNotificationWith(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Don't forget"
        content.body = "Buy some milk"
        content.sound = UNNotificationSound.default()
        
        return content
    }
    
    static func createCalendarTrigerFor(date: Date) -> UNCalendarNotificationTrigger {
        let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly,                                             repeats: true)
        
        return trigger
    }
    
    static func scheduleNotificationWith(identifier: String, content: UNMutableNotificationContent, trigger: UNCalendarNotificationTrigger) -> Bool {
        var isSuccess = false
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content, trigger: trigger)
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if let error = error {
                //TODO: Add logger action
                isSuccess = false
            }
        })
        
        return isSuccess
    }
    
}
