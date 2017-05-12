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
    
}
