//
//  ViewController.swift
//  NotificationManager
//
//  Created by Igor Lantushenko on 12/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. Request permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
        })
    }
    
    @IBAction func notificationBtn(_ sender: Any) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Success!!")
            } else {
                print("BAD!!")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let notification = UNMutableNotificationContent()
        
        guard let imgUrl = Bundle.main.url(forResource: "test", withExtension: "jpg")  else {
            completion(false)
            return
        }
        
        let attachment: UNNotificationAttachment!
        
        do {
         try attachment = UNNotificationAttachment(identifier: "myNotification", url: imgUrl, options: .none)
        } catch {
            print(error)
            completion(false)
            return
        }
        
        notification.categoryIdentifier = "myNotificationCategory"
        notification.title = "My notification"
        notification.subtitle = "Thats work amazing!"
        notification.body = "My first notification is released. Check it out!"
        notification.attachments = [attachment]
        
        let notifytrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notification, trigger: notifytrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        })
        
    }
    
    
    
}

