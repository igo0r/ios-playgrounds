//
//  WeekDayControllerExt.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 23/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

extension WeekDayController {
    
    func isFormValid() -> Bool {
        let isValid = validateDatePickers() && validateActiveWeekDays()
        
        if isValid {
            saveBtn.tintColor = green
        } else {
            saveBtn.tintColor = redColor
        }
        
        return isValid
    }
    
    func validateDatePickers() -> Bool {
        var isValid = false
        if sleepAt != nil && wakeUpAt != nil {
            if !DateTimeUtils.isTimeIntervalLess(than: secondsFrom3Hours, betweenDate1: sleepAt!, andDate2: wakeUpAt!) {
                sleepAtLbl.textColor = white
                validationSleepLbl.isHidden = true
                isValid = true
            } else {
                sleepAtLbl.textColor = redColor
                validationSleepLbl.text = "At least 3 hours from wake up"
                validationSleepLbl.textColor = redColor
                validationSleepLbl.isHidden = false
                isValid = false
            }
        }
        
        return isValid
    }
    
    func validateActiveWeekDays() -> Bool {
        var isValid = false
        if getActiveWeekDays().isEmpty {
            applyDaysLbl.textColor = redColor
            validationWeekDaySLbl.text = "At least 1 day from the week"
            validationWeekDaySLbl.textColor = redColor
            validationWeekDaySLbl.isHidden = false
            isValid = false
        } else {
            applyDaysLbl.textColor = white
            validationWeekDaySLbl.isHidden = true
            isValid = true
        }
        
        return isValid
    }
}
