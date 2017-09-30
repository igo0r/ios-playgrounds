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
    @objc dynamic var startAt = NSDate()
    @objc dynamic var descriptionText = ""
    @objc dynamic var titleText = ""
    @objc dynamic var weekDay: WeekDay?
    
    /*
     create time event from recurrent event
     */
    func creareTimeEvent() -> TimeEvent {
        let timeEvent = TimeEvent(startAt: startAt as Date, description: titleText, notificationDescription: descriptionText, weekDay: weekDay)
        
        return timeEvent
    }
}
