//
//  RealmManager.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 07/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class TimeEventRealmManager {
    static let sharedInstance = TimeEventRealmManager()
    static let dq = DispatchQueue.global(qos: .userInteractive)
    private let realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    /*
     get timeEvents for weekday
     */
    static func loadTimeEventsFor(weekDay: WeekDay) -> [TimeEvent] {
        let recurrentEvents = loadRecurrentEventsFor(weekDay: weekDay)
        return recurrentEvents.flatMap {$0.creareTimeEvent()}
    }
    
    /*
     get recurrent events for weekday
     */
    static func loadRecurrentEventsFor(weekDay: WeekDay) -> Results<RecurrentEvent> {
        let realm = try! Realm()
        let objs = realm.objects(RecurrentEvent.self).filter("weekDay == %@", weekDay).sorted(byKeyPath: "startAt")
            
        return objs
    }
    
    /*
     transform timeEvent to recurrent and save it
     */
    static func writeTimeEvents(objs: [TimeEvent]) {
        let recurrentEvents = objs.flatMap {$0.createReccurentEvent()}
        writeRecurrentEvents(objs: recurrentEvents)
    }
    
        
    /*
     save recurrent events for weekday but before delete all events for this day
     */
    static func writeRecurrentEvents(objs: [RecurrentEvent]) {
        dq.sync {
            if let weekDay = objs[0].weekDay {
                deleteRecurrentEventsFor(weekDay: weekDay)
            }
            
            print("Before SAVE Recurrent Event =")
            let realm = try! Realm()
            try! realm.write {
                realm.add(objs)
            }
        }
    }
    
    static func deleteRecurrentEventsFor(weekDay: WeekDay) {
        let days = loadRecurrentEventsFor(weekDay: weekDay)
        let realm = try! Realm()
        try! realm.write {
            realm.delete(days)
        }
    }
}
