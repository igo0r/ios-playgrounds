//
//  RealmMigrationManager.swift
//  
//
//  Created by Igor Lantushenko on 09/08/2017.
//
//

import Foundation
import RealmSwift

class RealmMigrationManager {
    static let sharedInstance = RealmMigrationManager()
    
    private init() {}
    
    static func migrate() {
        //print realm url
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let config = Realm.Configuration(
            schemaVersion: 1,
            
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
    }
}
