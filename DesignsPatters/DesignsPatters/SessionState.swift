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
 
 No value-types!
 No copies/cloning
 */
public class SessionState {
    
    private var storage = [String: Any]()
    
    //Make storage getter and setter thread safe with synchronius queuee
    //private let sync = DispatchQueue(label: "syncQueuee")
    private let aSynq = DispatchQueue(label: "async", attributes: .concurrent, target: nil)
    
    private init() {}
    
    //Swift guarantees that lazily initialized globals or static properties are thread-safe
    //GCD dispatch_once is not needed to create singletone
    //and its no longer available in Swift 3
    public static let shared = SessionState()
    
    //Create a synq queuee
    public func set<T>(_ value: T?, forKey key: String) {
        //sync.sync {
        aSynq.async(flags: .barrier) {
            if value == nil {
                if self.storage.removeValue(forKey: key) != nil {
                    print("key \(key) was removed")
                } else {
                    print("No value for key")
                }
            }
            self.storage[key] = value
        }
    }
    
    //Create a synq queuee
    public func object<T>(forKey key: String) -> T? {
        var result: T?
        //sync.sync {
        aSynq.async {
            result = self.storage[key] as? T ?? nil
        }
        
        return result
    }
    
}
