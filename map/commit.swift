//
//  event.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 6..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation

class Start:commit {
    var members = [Member]()
    var type: eventType
    let time:Date
    
    required init(_ members: [Member]) {
        type = .start
        time = Date()
        if members.count > 0 {
            self.members += members
        }
    }
}

class Route: commit {
    var type: eventType
    var members = [Member]()
    var routes = [CLLocation]()
    
    required init(_ members: [Member]) {
        type = .route
        if members.count > 0 {
            self.members += members
        }
    }
    
}

class End: commit {
    var type: eventType
    var members = [Member]()
    let time:Date
    
    required init(_ members: [Member]) {
        type = .end
        time = Date()
        if members.count > 0 {
            self.members += members
        }
    }
}

class Pause: commit {
    var type: eventType
    var members = [Member]()
    let time:Date
    
    required init(_ members: [Member]) {
        type = .pause
        time = Date()
        if members.count > 0 {
            self.members += members
        }
    }
}

class Resume: commit {
    var type: eventType
    var members = [Member]()
    let time:Date
    
    required init(_ members: [Member]) {
        type = .resume
        time = Date()
        if members.count > 0 {
            self.members += members
        }
    }
}

class Photo: commit {
    var type: eventType
    var members = [Member]()
    var photo: photo?
    
    required init(_ members: [Member]) {
        type = .resume
        if members.count > 0 {
            self.members += members
        }
        photo = nil
    }

     init(_ members: [Member], media:photo) {
        type = .resume
        if members.count > 0 {
            self.members += members
        }

        photo = media
    }
}

protocol commit {
    var type:eventType {get set}
    var members:[Member] {get set}
    init(_ members: [Member])
}

enum eventType {
    case start
    case end
    case pause
    case resume
    case route
    case photo
    case video
    case memo
}
