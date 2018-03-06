//
//  trip.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 6..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

struct trip {
    var name:String
    public var start:Date
    var status:tripStatus
    var locations: Set<location>

    mutating func startTrip(when time:Date) {
        start = time
    }
    mutating func addLocation(here locate:location) {
        locations.insert(locate)
    }
    
    mutating func deleteLocation(here locate:location) {
        locations.remove(locate)
    }
}

enum tripStatus {
    case plan
    case traveling
    case idle
    case garbage
}

struct location:Hashable {
    var hashValue: Int
    
    static func ==(lhs: location, rhs: location) -> Bool {
        return false
    }
    
    
}
