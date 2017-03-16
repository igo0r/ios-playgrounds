//
//  NotificationViewController.swift
//  UniqueCOntentExtensions
//
//  Created by Igor Lantushenko on 13/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
        
            let imageData = try? Data.init(contentsOf: attachment.url)
            if let image = imageData {
                imageView.image = UIImage(data: image)
            }
        }
        
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "poop" {
            completion(.dismiss)
        } else if response.actionIdentifier == "dismiss" {
            completion(.dismiss)
        }
    }

}
