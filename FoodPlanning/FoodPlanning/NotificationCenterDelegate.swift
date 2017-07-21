//
//  NotificationCenterDelegate.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 24/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationCenterDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    /*
     handle notification when app is in a foreground
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        BackgroundTaskTracker.requestToUpdateNotifications()
        
        UserDefaultsUtils.increaseSuccessPath()
        completionHandler(.alert)
    }
    
    /*
     handle notification when user press some action on lock screen
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Response receive for \(response.actionIdentifier)")
        
        BackgroundTaskTracker.requestToUpdateNotifications()
        
        UserDefaultsUtils.increaseSuccessPath()
        completionHandler()
    }

}
