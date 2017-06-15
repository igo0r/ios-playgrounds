//
//  BackgroundTaskManager.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 13/06/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit

class BackgroundTaskManager {
    //let backgroundDQ = DispatchQueue.global(qos: .background)
    let backgroundDQ = DispatchQueue(label: "com.FoodPlannerApp")
    var backgroundUpdateTask: UIBackgroundTaskIdentifier!
    
    init(withName: String) {
        
        self.backgroundUpdateTask = UIApplication.shared.beginBackgroundTask(withName: withName) {}
    }
    
    func doBackgroundTask(withCode: @escaping (_ cH: @escaping () -> Void) -> Void)
    {
        backgroundDQ.async {
            withCode() {
                print("GO AND END THAT TASK!")
                self.endBackgroungTask()
            }
            //
        }
    }
    
    func endBackgroungTask() {
        if backgroundUpdateTask != nil && backgroundUpdateTask != UIBackgroundTaskInvalid {
            UIApplication.shared.endBackgroundTask(backgroundUpdateTask)
            backgroundUpdateTask = UIBackgroundTaskInvalid
            
            BackgroundTaskTracker.proceedNextBackgroundTask()
        }
        
    }
    
}
