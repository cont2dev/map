//
//  event.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 6..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

struct event {
    let type:eventType
    let start:Date
    var end:Date
}

enum eventType {
    case route
    case photo
    case video
    case memo
}
