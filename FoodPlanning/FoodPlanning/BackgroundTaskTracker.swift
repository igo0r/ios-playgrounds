//
//  BackgroundTaskManager.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 13/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit

class BackgroundTaskTracker {

    static let sharedInstance = BackgroundTaskTracker()
    static var backgroundManageNotifications: UIBackgroundTaskIdentifier!
    static var backgroundNotificationsInProgress = false
    static var updateNotifications = false
    
    /*
     starting point - signal to start background process
     */
    static func requestToUpdateNotifications() {
        print("requestToUpdateNotifications")
        updateNotifications = true
        initiateNotificationsUpdate()
    }
    
    /*
     check if backgroung task not in progress and than start new one
     */
    static func initiateNotificationsUpdate() {
        if updateNotifications && !backgroundNotificationsInProgress {
            updateNotifications = false
            backgroundNotificationsInProgress = true
            beginBackgroundTask()
            doBackgroundTask()
        }
    }
    
    /*
     start new background task
     */
    static func beginBackgroundTask() {
        if backgroundManageNotifications == nil || backgroundManageNotifications == UIBackgroundTaskInvalid {
            print("beginBackgroundTask")
            backgroundManageNotifications = UIApplication.shared.beginBackgroundTask(withName: "buildNotificationsManager") {}
        }
    }
    
    /*
     build notifications
     */
    static func doBackgroundTask()
    {
        print("do buildLocalNotifications !!")
        let localNotifications = LocalNotificationClass()
        localNotifications.buildLocalNotifications()
    }
    
    /*
     check if next background task exists and than start it
     */
    static func proceedNextBackgroundTask() {
        print("proceedNextBackgroundTask")
        backgroundNotificationsInProgress = false
        if updateNotifications {
            initiateNotificationsUpdate()
        } else if backgroundManageNotifications != nil && backgroundManageNotifications != UIBackgroundTaskInvalid {
            print("end BackgroundTaskTracker")
            UIApplication.shared.endBackgroundTask(backgroundManageNotifications)
            backgroundManageNotifications = UIBackgroundTaskInvalid
        }
    }

}
