//
//  WeekDayBtn.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 04/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import UIKit

class WeekDayBtn: UIButton {
  
    override func draw(_ rect: CGRect) {
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel?.textAlignment = NSTextAlignment.center
        
        let weekAttrString = composeAttributedStringForWeekBtn(withActiveState: false)
        self.setAttributedTitle(weekAttrString, for: .normal)
        setButtonToday()
    }
    
    /*
     f.e. 01 Nov
     */
    func composeAttributedStringForWeekBtn(withActiveState: Bool) -> NSAttributedString {
        let weekDays = DateTimeUtils.getCurrentWeek()
        let weekDay = DateTimeUtils.routeFromDayTagToWeekDays(btnTag: tag)
        let date = weekDays[weekDay]!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        var weekStr = formatter.string(from: date).uppercased()
        
        weekStr.append("\n")
        formatter.dateFormat = "dd"
        
        let dayStr = formatter.string(from: date)
        
        let weekDayColor: UIColor
        //if DateTimeUtils.getCurrentDate() == date  {
        if withActiveState {
            weekDayColor = whiteColor
            //setButtonActive(true)
        } else {
            weekDayColor = grayColor
        }
        
        let weekAttrString = NSMutableAttributedString(
            string: weekStr,
            attributes: [
                NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 11)!,
                NSAttributedStringKey.foregroundColor: weekDayColor
            ]
        )
        let dayAttrString = NSMutableAttributedString(
            string: dayStr,
            attributes: [
                NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 22)!,
                NSAttributedStringKey.foregroundColor: whiteColor            ]
        )
        
        weekAttrString.append(dayAttrString)
        
        return weekAttrString
    }
    
    /*
     add red background when press button
     */
    func setButtonActive(_ isActive: Bool) {
        if isActive {
            let attrStr = composeAttributedStringForWeekBtn(withActiveState: true)
            
            self.setBackgroundColor(color: redColor, forState: .normal)
            self.setAttributedTitle(attrStr, for: .normal)
        } else {
            let attrStr = composeAttributedStringForWeekBtn(withActiveState: false)
            
            self.setBackgroundColor(color: UIColor.clear, forState: .normal)
            self.setAttributedTitle(attrStr, for: .normal)
        }
    }
    
    /*
     add white frame for current date
     */
    func setButtonToday() {
        let btnWeekDay = DateTimeUtils.routeFromDayTagToWeekDays(btnTag: tag)
        let currentWeekDay = DateTimeUtils.getCurrentWeekDayNumber()
        
        if currentWeekDay == btnWeekDay {
            layer.borderColor = white.cgColor
            layer.borderWidth = 1
        } else {
            layer.borderWidth = 0
        }
    }
    
    func setButtonActive(_ isActive: Bool, withTag: WeekDays) {
        if tag == withTag.rawValue {
            setButtonActive(isActive)
        }
    }
}
