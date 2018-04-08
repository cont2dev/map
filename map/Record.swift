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
    var type: recordType
    let time: Date
    
    required init(_ members: [Member]) {
        type = .start
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Route: Record {
    var type: recordType
    var members = [Member]()
    var location: CLLocation?
    
    required init(_ members: [Member]) {
        type = .route
        location = nil

        if members.count > 0 {
            self.members = members
        }
    }
    
    init (_ members: [Member], _ location: CLLocation) {
        type = .route
        
        if members.count > 0 {
            self.members = members
        }
        
        self.location = location
    }
}

class End: Record {
    var type: recordType
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        type = .end
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Pause: Record {
    var type: recordType
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        type = .pause
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Resume: Record {
    var type: recordType
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        type = .resume
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Photo: Record {
    var type: recordType
    var members = [Member]()
    var photo: photo?
    
    required init(_ members: [Member]) {
        type = .photo
        self.photo = nil
        
        if members.count > 0 {
            self.members = members
        }
    }

    init(_ members: [Member], media: photo) {
        type = .resume
        self.photo = media
        
        if members.count > 0 {
            self.members = members
        }
    }
}

protocol Record {
    var type: recordType {get set}
    var members: [Member] {get set}
    init(_ members: [Member])
}

enum recordType: String {
    case start = "Start"
    case end = "End"
    case pause = "Pause"
    case resume = "Resume"
    case route = "Route"
    case photo = "Photo"
    case video = "Video"
    case memo = "Memo"
}
