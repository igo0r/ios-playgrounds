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
        let isValidDatePickers = validateDatePickers()
        let isValidWeekDays = validateActiveWeekDays()
        if isValidDatePickers && isValidWeekDays {
            saveBtn.tintColor = green
        } else {
            saveBtn.tintColor = redColor
        }
        
        return isValidDatePickers && isValidWeekDays
    }
    
    /*
     check timedifference between start and sleep at least 3 hours
     */
    func validateDatePickers() -> Bool {
        var isValid = false
        if sleepAt != nil && wakeUpAt != nil {
            validationSleepLbl.text = "At least 3 hours from wake up"
            if !DateTimeUtils.isTimeIntervalLess(than: secondsFrom3Hours, betweenDate1: sleepAt!, andDate2: wakeUpAt!) {
                sleepAtLbl.textColor = white
                validationSleepLbl.isHidden = false
                validationSleepLbl.textColor = opacity0
                isValid = true
            } else {
                sleepAtLbl.textColor = redColor
                validationSleepLbl.textColor = redColor
                validationSleepLbl.isHidden = false
                isValid = false
            }
        }
        
        return isValid
    }
    
    /*
     check that at least 1 weekday is choosen
     */
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
            validationWeekDaySLbl.textColor = opacity0
            isValid = true
        }
        
        return isValid
    }
}
