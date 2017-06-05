//
//  RateApp.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 05/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class RateApp {
    
    /*
     using agree and disagree counters determine wether we should show rate popup or not
     */
    static func showRatePopupOnSuccessPath(forView: UIView) {
        if UserDefaultsUtils.getAgreeToReview() == 0 && UserDefaultsUtils.getSuccessPathes() % 1 == 0 {
            func askPreNotificationPermissions(withDismiss: Bool) -> UIAlertController {
                let alertToShow = UIAlertController(title: "Would you like to rate us?", message: "It seeems you have fun with an application. Please, help us to build better product for you :)", preferredStyle: UIAlertControllerStyle.alert)
                alertToShow.addAction(UIAlertAction(title: "Not Now", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in
                    UserDefaultsUtils.increasDisagreeToReview()
                }))
                alertToShow.addAction(UIAlertAction(title: "Rate Us", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
                    UserDefaultsUtils.increasAgreeToReview()
                    
                }))
                
                
                return alertToShow
            }
        }
    }
    
    func openRatingView() {
        
        if #available(iOS 10.3, *) {
            
            // Present rating alert
            SKStoreReviewController.requestReview()
            
        } else {
            RateApp.rateApp() { (success) in
                
            }
        }
    }
    
    /*
     build and open url for app rate
     */
    static func rateApp(completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appID + "?action=write-review") else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
}
