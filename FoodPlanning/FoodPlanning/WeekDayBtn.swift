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
    }
    
    func composeAttributedStringForWeekBtn(withActiveState: Bool) -> NSAttributedString {
        let weekDays = DateTimeUtils.getCurrentWeek()
        let date = weekDays[Int(tag)]
        
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
                NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 11)!,
                NSForegroundColorAttributeName: weekDayColor
            ]
        )
        let dayAttrString = NSMutableAttributedString(
            string: dayStr,
            attributes: [
                NSFontAttributeName: UIFont(name: "AvenirNext-DemiBold", size: 22)!,
                NSForegroundColorAttributeName: whiteColor            ]
        )
        
        weekAttrString.append(dayAttrString)
        
        return weekAttrString
    }
    
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
    
    func setButtonActive(_ isActive: Bool, withTag: WeekDays) {
        if tag == withTag.rawValue {
            setButtonActive(isActive)
        }
    }
}
