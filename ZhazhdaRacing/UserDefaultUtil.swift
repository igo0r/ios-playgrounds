//
//  UserDefaultUtil.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 19/09/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

class UserDefaultUtil {
    
    static func getTeamIdentifier() -> String {
        return UserDefaults.standard.string(forKey: teamIdentifier) ?? ""
    }
    
    static func setTeamIdentifier(identifier: Bool) {
        UserDefaults.standard.set(identifier, forKey: teamIdentifier)
    }
}
