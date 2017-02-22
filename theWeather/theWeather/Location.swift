//
//  Location.swift
//  theWeather
//
//  Created by Igor Lantushenko on 22/02/2017.
//  Copyright © 2017 Igor Lantushenko. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedLocation = Location()
    private init() {}
    
    var latitude: String!
    var longitude: String!
    
}
