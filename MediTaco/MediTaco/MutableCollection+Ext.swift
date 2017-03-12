//
//  MutableCollection+Ext.swift
//  MediTaco
//
//  Created by Igor Lantushenko on 07/03/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import Foundation

extension MutableCollection where Index == Int {
    mutating func shuffle() {
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - 1))) + 1
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
