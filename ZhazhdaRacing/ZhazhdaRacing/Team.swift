//
//  Team.swift
//  ZhazhdaRacing
//
//  Created by Igor Lantushenko on 23/08/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

struct Team {
    var name = ""
    var racer = ""
    var identifier = ""
    
    init() {
        self.name = ""
        self.racer = ""
        self.identifier = ""
    }
    
    init(name: String, racer: String) {
        self.name = name
        self.racer = racer
        self.identifier = ""
    }
    
    var fullName: String {
        return "\(name)/\(racer)"
    }
}
