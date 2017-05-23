//
//  Singleton.swift
//  Design patters
//
//  Created by Igor Lantushenko on 19/05/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation
/*
 Should be threat-safe
 Provide uniqueness of the object
 The only instance cannot be copied
 
 Provide thread-safe during initialization
 
 */
public class SessionState {
    
    private var storage = [String: Any]()
    
    private init() {}
    
    //Swift guarantees that lazily initialized globals or static properties are thread-safe
    //GCD dispatch_once is not needed to create singletone
    //and its no longer available in Swift 3
    public static var shared: SessionState {
        let instance = SessionState()
        return instance
    }
    
    public func set(_ value: Any, forKey key: String) {
        storage[key] = value
    }
    
    public func object(forKey key: String) -> Any? {
        return storage[key] ?? nil
    }
    
}
