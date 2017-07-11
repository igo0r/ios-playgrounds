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
        dq.sync {
            let realm = try! Realm()
            let days = loadWeekDay(forDay: obj.weekDay)
            for day in days {
                removeWeekDay(day, withNotifications: false)
            }
            print("Before SAVE OBJ ============")
            try! realm.write {
                realm.add(obj)
            }
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
            BackgroundTaskTracker.requestToUpdateNotifications()
        }
    }

    
    /*
     forDay from 0 ... 6 mon - sun
     */
    static func loadWeekDay(forDay: Int) -> Results<WeekDay> {
        let realm = try! Realm()
        return realm.objects(WeekDay.self).filter("weekDay == \(forDay)")
    }
    
    static func updateWeekDayWaterSettingsWith(obj: WeekDay, value: Bool) {
        let realm = try! Realm()
        try! realm.write {
            obj.withWater = value
        }
    }

    /*
     take today weekday. 
     f.e. Tuesday = 1 and build array like 1,2,3...6,0
     sorts from today
     */
    static func getAllWeekDaysSorted() -> [WeekDay] {
        let realm = try! Realm()
        let weekDay = DateTimeUtils.getCurrentWeekDayNumber()
        let result = realm.objects(WeekDay.self)
        
        let sortedResult = result.sorted(by: { (lhd, rhd) -> Bool in
            if lhd.weekDay >= weekDay.rawValue && rhd.weekDay < weekDay.rawValue {
               return lhd.weekDay > rhd.weekDay
            } else if lhd.weekDay < weekDay.rawValue && rhd.weekDay >= weekDay.rawValue {
                return lhd.weekDay > rhd.weekDay
            }
            
            return lhd.weekDay < rhd.weekDay
        })
        
        return sortedResult
    }
    
    static func getAllWeekDays() -> Results<WeekDay> {
        let realm = try! Realm()
        return realm.objects(WeekDay.self)
    }
    
}
