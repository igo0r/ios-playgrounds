//
//  SettingViewControllerTableViewController.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 04/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UITableViewController {

    @IBOutlet weak var notificationSwitcher: UISwitch!
    var callConfigView = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavBar(withTitle: "Settings")
        configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocalNotificationUtils.isAuthorizedToSendNotifications() { (isAuth) in
            DispatchQueue.main.async {
                self.notificationSwitcher.setOn(isAuth, animated: true)
            }
        }
    }

    @IBAction func notificationSwitchAction(_ sender: UISwitch) {
        enableLocalNotifications(sender.isOn) { result in
            DispatchQueue.main.async {
                sender.setOn(result, animated: true)
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        } else if indexPath.row == 2 {
            RateApp.rateApp() { (success) in
                
            }
        }
    }

    /*
     monitoring notification changes
     */
    @objc func willEnterForeground() {
        print("Enter foreground")
        LocalNotificationUtils.isAuthorizedToSendNotifications() { (isAuth) in
            self.notificationSwitcher.setOn(isAuth, animated: true)
        }
    }
}
