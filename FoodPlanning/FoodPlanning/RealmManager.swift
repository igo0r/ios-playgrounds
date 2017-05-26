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
    
    private init() {
        realm = try! Realm()
    }
    
    static func loadEventsFor(day: WeekDays, _ completionHandler: @escaping (WeekDay?) -> ()) {
        //return realm.objects(WeekDay.self).filter("weekDay == \(day.rawValue)")
        DispatchQueue.main.async {
            let realm = try! Realm()
            let obj = realm.objects(WeekDay.self).filter("weekDay == \(day.rawValue)").first
        
            completionHandler(obj)
        }
    }
    
    static func writeWeekDay(obj: WeekDay) {
        DispatchQueue.main.async {
            let realm = try! Realm()
            let days = realm.objects(WeekDay.self).filter("weekDay == \(obj.weekDay)")
            for day in days {
                try! realm.write {
                    let dayOfWeek = WeekDays(rawValue: day.weekDay)!
                    realm.delete(day)
                    LocalNotificationUtils.removeLocalNotificationsFor(dayOfWeek: dayOfWeek)
                }
            }
            try! realm.write {
                realm.add(obj)
                obj.createLocalNotificationsForCurrentDay()
            }
        }
    }
    
    static func getAllWeekDays(realm: Realm) -> Results<WeekDay> {
        return realm.objects(WeekDay.self)
    }
    
}
