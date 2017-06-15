//
//  AppDelegate.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 24/04/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationDelegate = NotificationCenterDelegate()
    let applicationState = UIApplication.shared.applicationState
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: white, NSFontAttributeName: UIFont(name: "AvenirNext-Medium", size: 21)!]
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let center = UNUserNotificationCenter.current()
        center.delegate = notificationDelegate
        let category = getNotificationActionsWithCategory()
        center.setNotificationCategories([category])
        
        UserDefaultsUtils.increaseSuccessPath()
        //LocalNotificationManager.buildLocalNotifications()
        BackgroundTaskTracker.requestToUpdateNotifications()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        /*var counter = 20
        while counter >= 0 {
            print("applicationWillResignActive \(counter)")
            counter = counter - 1
            sleep(1)
        }*/
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        //LocalNotificationManager.buildLocalNotifications()
        /*DispatchQueue.main.async {
            var counter = 30
            while counter >= 0 {//&& applicationState != .active {
                print("applicationDidEnterBackground \(counter)")
                counter = counter - 1
                sleep(1)
            }
        }*/
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("Cool")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        /*var counter = 10
        while counter >= 0 {
            print("applicationWillTerminate \(counter)")
            counter = counter - 1
            sleep(1)
        }*/
    }
    
    func getNotificationActionsWithCategory() -> UNNotificationCategory {
        let okAction = UNNotificationAction(identifier: "Ok", title: "Ok", options: [])
        let category = UNNotificationCategory(identifier: okNotificationCategory,                                        actions: [okAction], intentIdentifiers: [], options: [])
        
        return category
    }
}

