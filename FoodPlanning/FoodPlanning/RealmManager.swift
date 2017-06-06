//
//  RealmManager.swift
//  FoodPlanning
//
//  Created by Igor Lantushenko on 07/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    static let sharedInstance = RealmManager()
    private let realm: Realm
    static let dq = DispatchQueue.global(qos: .userInteractive)
    
    private init() {
        realm = try! Realm()
    }
    
    static func loadEventsFor(day: WeekDays, _ completionHandler: @escaping (WeekDay?) -> ()) {
        //return realm.objects(WeekDay.self).filter("weekDay == \(day.rawValue)")
        //DispatchQueue.main.async {
        dq.sync {
            let realm = try! Realm()
            let obj = realm.objects(WeekDay.self).filter("weekDay == \(day.rawValue)").first
        
            //DispatchQueue.main.async {
                completionHandler(obj)
            //}
        }
    }
    
    static func writeWeekDay(obj: WeekDay) {
        //DispatchQueue.main.async {
        dq.sync {
            let realm = try! Realm()
            let days = loadWeekDay(forDay: obj.weekDay)
            //let group  = DispatchGroup()
            //group.enter()
            for day in days {
                removeWeekDay(day, withNotifications: false)
            }
            
            //group.leave()
            //group.notify(queue: DispatchQueue.main) { () in
                print("Before SAVE OBJ ============")
                try! realm.write {
                    realm.add(obj)
                    //obj.createLocalNotificationsForCurrentDay()
                }
            //}
        }
    }
    
    /*
     forDay from 0 ... 6 mon - sun
     */
    static func removeWeekDay(_ day: WeekDay, withNotifications: Bool) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(day)
        }
        if withNotifications {
            LocalNotificationManager.buildLocalNotifications()
        }
    }

    
    /*
     forDay from 0 ... 6 mon - sun
     */
    static func loadWeekDay(forDay: Int) -> Results<WeekDay> {
        let realm = try! Realm()
        return realm.objects(WeekDay.self).filter("weekDay == \(forDay)")
    }
    
    static func getAllWeekDays() -> Results<WeekDay> {
        let realm = try! Realm()
        return realm.objects(WeekDay.self)
    }
    
}
