//
//  Item+CoreDataClass.swift
//  DreamList
//
//  Created by Igor Lantushenko on 11/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
