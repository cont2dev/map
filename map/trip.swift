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
    var start:Date
    var status:tripStatus
    var locations: [location]
}

enum tripStatus {
    case plan
    case traveling
    case idle
    case garbage
}

struct location {
}
