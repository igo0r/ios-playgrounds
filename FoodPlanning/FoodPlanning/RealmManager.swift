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
    
    static func writeObject(obj: Any, realm: Realm) {
        if let weekDay = obj as? WeekDay {
            try! realm.write {
                realm.add(weekDay)
            }
        }
    }
    
    static func getAllWeekDays(realm: Realm) -> Results<WeekDay> {
        return realm.objects(WeekDay.self)
    }
    
}
