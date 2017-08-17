//
//  WeekDayWaterForm.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 03/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class WeekDayWaterForm: DefaultWaterForm {
    private var weekDays: [WeekDay]?
    private var timeEvents: [TimeEvent]?
    
    init() {
        super.init(withWaterCondition: .WaterWeekDayView)
        setNavBarTitle("Day plan. Step 2")
    }
    
    func getWeekDays() -> [WeekDay]? {
        return weekDays
    }
    
    func setWeekDays(_ weekDays: [WeekDay]) {
        self.weekDays = weekDays
    }
    
    func getTimeEvents() -> [TimeEvent]? {
        return timeEvents
    }
    
    func setTimeEvents(_ timeEvents: [TimeEvent]) {
        self.timeEvents = timeEvents
    }
    
    func shouldBeUpdated() -> Bool {
        if updateWaterForm || timeEvents == nil || timeEvents?.count == 0 {
            return true
        }
        
        return false
    }

}
