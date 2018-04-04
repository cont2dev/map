//
//  event.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 6..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation

class Start: Record {
    var members = [Member]()
    var type: eventType
    let time: Date
    
    required init(_ members: [Member]) {
        type = .start
        time = Date()
        
        if self.members.count > 0 && members.count > 0 {
            self.members = members
        }
    }
}

class Route: Record {
    var type: eventType
    var members = [Member]()
    var routes = [CLLocation]()
    
    required init(_ members: [Member]) {
        type = .route

        if self.members.count > 0 && members.count > 0 {
            self.members = members
        }
    }
    
}

class End: Record {
    var type: eventType
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        type = .end
        time = Date()
        
        if self.members.count > 0 && members.count > 0 {
            self.members = members
        }
    }
}

class Pause: Record {
    var type: eventType
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        type = .pause
        time = Date()
        
        if self.members.count > 0 && members.count > 0 {
            self.members = members
        }
    }
}

class Resume: Record {
    var type: eventType
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        type = .resume
        time = Date()
        
        if self.members.count > 0 && members.count > 0 {
            self.members = members
        }
    }
}

class Photo: Record {
    var type: eventType
    var members = [Member]()
    var photo: photo?
    
    required init(_ members: [Member]) {
        type = .resume
        self.photo = nil
        
        if self.members.count > 0 && members.count > 0 {
            self.members = members
        }
    }

    init(_ members: [Member], media: photo) {
        type = .resume
        self.photo = media
        
        if self.members.count > 0 && members.count > 0 {
            self.members = members
        }
    }
}

protocol Record {
    var type: eventType {get set}
    var members: [Member] {get set}
    init(_ members: [Member])
}

enum eventType: String {
    case start = "Start"
    case end = "End"
    case pause = "Pause"
    case resume = "Resume"
    case route = "Route"
    case photo = "Photo"
    case video = "Video"
    case memo = "Memo"
}
