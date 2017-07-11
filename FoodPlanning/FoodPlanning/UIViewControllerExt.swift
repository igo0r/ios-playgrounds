//
//  UIViewExtension.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 07/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension UIViewController {
        
    var realm: Realm {
        return try! Realm()
    }
    
    var defaultDate: WeekDays{
        get {
            return UserDefaultsUtils.getDefaultUserDate()
        } set {
            UserDefaultsUtils.setDefaultUserDate(weekDay: newValue)
        }
    }
    
    func configureView() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "lemons")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        
        let backgroundView = UIView(frame: UIScreen.main.bounds)
        backgroundView.backgroundColor = black
        backgroundImage.addSubview(backgroundView)
        view.insertSubview(backgroundImage, at: 0)
    }
    
    func configureNavBar(withTitle: String) {
        if let navItem = self.navigationController?.navigationBar.topItem {
            let navBar = navigationController?.navigationBar
            navBar?.isTranslucent = false
            
            navItem.title = withTitle
            //navItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "menu.png"), style: UIBarButtonItemStyle.plain, target: nil, action: nil), animated: false)
            //navItem.leftBarButtonItem?.tintColor = UIColor(hex: "E4E0E0", alpha: 1)
        }
    }

    func openAppSettings() {
        if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
         UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
         }
    }
    
    /*
     In case when user didnt allow send notifications but still uses the app
     */
    func askPostUnsuccessNotificationPermissions(withDismiss: Bool) -> UIAlertController {
        let alert = UIAlertController(title: "Still disabled notifications :(", message: "Unfortunately we can't inform you about upcoming meals in time because notifications are disabled for our application.\n However you can change it by following \"Settings\" button", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in
            self.openAppSettings()
            UserDefaultsUtils.increasRequestPermissionsCounter()
            if withDismiss {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
            UserDefaultsUtils.increasRequestPermissionsCounter()
            if withDismiss {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        
        return alert
    }
    
    /*
     ask permissions the first time and if user allow - show real permission popup
     */
    func askPreNotificationPermissions(withDismiss: Bool) -> UIAlertController {
        let alertToShow = UIAlertController(title: "Let us notify you just in time!", message: "In order to send you notifications about scheduled comming meals. We are asking you to give us permissions to do so.\n If you agree - just press \"Ok\" or \"Cancel\" to ask later.", preferredStyle: UIAlertControllerStyle.alert)
        alertToShow.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in
            LocalNotificationUtils.askNotificationPermissions()
            UserDefaultsUtils.increasRequestPermissionsCounter()
            if withDismiss {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        alertToShow.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
            if withDismiss {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        
        
        return alertToShow
    }
    
    /*
     permission manager
     if permission counter = 0 and notAuth - first time enter ask
     if permission counter > 0 and every 3-rd time and not auth - ask every 3-rd time about permissions
     */
    func askNotificationPermissionsIfNeeded(withDismiss: Bool, cH: @escaping (UIAlertController?) -> ()) {
        let counter = UserDefaultsUtils.getRequestPermissionsCounter()
        let savePlanCounter = UserDefaultsUtils.getSavePlanCounter()
        var alertToShow: UIAlertController? = nil
        LocalNotificationUtils.isAuthorizedToSendNotifications() { (isAuth) in
            if !isAuth && counter > 0 && (savePlanCounter % 3 == 0) {
                alertToShow = self.askPostUnsuccessNotificationPermissions(withDismiss: withDismiss)
            } else if !isAuth && counter == 0 && (savePlanCounter % 3 == 0) {
                alertToShow = self.askPreNotificationPermissions(withDismiss: withDismiss)
            }
            
            cH(alertToShow)
        }
    }
    
    func enableLocalNotifications(_ enable: Bool, cH: @escaping (Bool) -> ()) {
        let counter = UserDefaultsUtils.getRequestPermissionsCounter()
        if enable && counter == 0 {
            UserDefaultsUtils.increasRequestPermissionsCounter()
            LocalNotificationUtils.askNotificationPermissions() { cH($0)}
        } else {
            let alertToShow = UIAlertController(title: "Change notification settings", message: "Enabling or disabling notifications only possible from main menu.\n Press \"Main menu\" to change conditions.", preferredStyle: UIAlertControllerStyle.alert)
            alertToShow.addAction(UIAlertAction(title: "Main menu", style: UIAlertActionStyle.cancel) { (alert: UIAlertAction!) in
                self.openAppSettings()
                cH(!enable)
            })
            alertToShow.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { (alert) in cH(!enable)} )

            self.present(alertToShow, animated: true, completion: nil)
        }
    }
}
