//
//  WeekDayFormBtn.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 13/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

@IBDesignable
class WeekDayFormBtn: UIButton {
    
    var isActiveWeekDay = false
    
    let checkImg = UIImage(named: "CheckWeekDay")
    
    /*
     btn tags 0..6
     */
    override func draw(_ rect: CGRect) {
        let weekDays = DateTimeUtils.getCurrentWeek()
        let btnWeekDay = DateTimeUtils.routeFromDayTagToWeekDays(btnTag: tag)
        let date = weekDays[btnWeekDay]!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        let weekStr = formatter.string(from: date).lowercased()
        
        setTitle(weekStr, for: .normal)
        if btnWeekDay == WeekDays(rawValue: 6) || btnWeekDay == WeekDays(rawValue: 5) {
            setTitleColor(redColor, for: .normal)
        } else {
            setTitleColor(white, for: .normal)
        }
        tintColor = green
    }
    
    /*
     week days mon, tue.. to set active
     */
    func setActive(_ active: Bool) {
        if active {
            isActiveWeekDay = true
            layer.borderColor = green.cgColor
            layer.borderWidth = 2
        } else {
            isActiveWeekDay = false
            layer.borderColor = white.cgColor
            setImage(nil, for: .normal)
            layer.borderWidth = 1
        }
    }

}
