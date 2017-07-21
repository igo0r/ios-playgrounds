//
//  RecurrentEvent.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 15/07/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import RealmSwift

class RecurrentEvent: Object {
    dynamic var startAt = NSDate()
    dynamic var descriptionText = ""
    dynamic var weekDay: WeekDay?
    
    /*
     create time event from recurrent event
     */
    func creareTimeEvent() -> TimeEvent {
        let timeEvent = TimeEvent(startAt: startAt as Date, description: descriptionText, notificationDescription: descriptionText, weekDay: weekDay)
        
        return timeEvent
    }
}
