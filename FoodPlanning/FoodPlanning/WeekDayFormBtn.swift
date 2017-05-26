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
    
    override func draw(_ rect: CGRect) {
        let weekDays = DateTimeUtils.getCurrentWeek()
        let date = weekDays[Int(tag)]
        
        let formatter = DateFormatter()
        formatter.dateFormat = " EE"
        let weekStr = formatter.string(from: date).lowercased()
        
        setTitle(weekStr, for: .normal)
        tintColor = green
    }
    
    func setActive(_ active: Bool) {
        if active {
            isActiveWeekDay = true
            layer.borderColor = green.cgColor
            setImage(checkImg, for: .normal)
            layer.borderWidth = 2
        } else {
            isActiveWeekDay = false
            layer.borderColor = white.cgColor
            setImage(nil, for: .normal)
            layer.borderWidth = 1
        }
    }

}
