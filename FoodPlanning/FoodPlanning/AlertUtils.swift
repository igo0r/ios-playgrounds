//
//  AlertUtils.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit

class AlertUtils {
    static func removeWeekDayWithAlert(withTitle title: String, message: String, forWeekDay: WeekDay, inView: UIViewController, cH: @escaping (Bool) -> ()) {
        let alertToShow = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertToShow.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: {(alert: UIAlertAction!) in
            RealmManager.removeWeekDay(forWeekDay, withNotifications: true)
            cH(true)
        }))
        alertToShow.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in
            cH(false)
        }))
        
        inView.present(alertToShow, animated: true, completion: nil)
    }
}
