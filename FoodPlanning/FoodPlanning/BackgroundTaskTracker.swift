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
    
    static func requestToUpdateNotifications() {
        print("requestToUpdateNotifications")
        updateNotifications = true
        initiateNotificationsUpdate()
    }
    
    static func initiateNotificationsUpdate() {
        if updateNotifications && !backgroundNotificationsInProgress {
            updateNotifications = false
            backgroundNotificationsInProgress = true
            beginBackgroundTask()
            doBackgroundTask()
        }
    }
    
    static func beginBackgroundTask() {
        if backgroundManageNotifications == nil || backgroundManageNotifications == UIBackgroundTaskInvalid {
            print("beginBackgroundTask")
            backgroundManageNotifications = UIApplication.shared.beginBackgroundTask(withName: "buildNotificationsManager") {}
        }
    }
    
    static func doBackgroundTask()
    {
        print("do buildLocalNotifications !!")
        let localNotifications = LocalNotificationClass()
        localNotifications.buildLocalNotifications()
    }
    
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
