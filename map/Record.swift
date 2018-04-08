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

class Route: Record, Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case type
        case members
        case location
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(recordType.self, forKey: .type)
        members = try values.decode([Member].self, forKey: .members)
        let locationModel = try values.decode(Location.self, forKey: .location)
        location = CLLocation(model: locationModel)
    }
}

extension CLLocation: Encodable {
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case altitude
        case hAccuracy
        case vAccuracy
        case course
        case speed
        case timestamp
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(horizontalAccuracy, forKey: .hAccuracy)
        try container.encode(verticalAccuracy, forKey: .vAccuracy)
        try container.encode(course, forKey: .course)
        try container.encode(speed, forKey: .speed)
        try container.encode(timestamp, forKey: .timestamp)
    }
}

struct Location: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let altitude: CLLocationDistance
    let hAccuracy: CLLocationAccuracy
    let vAccuracy: CLLocationAccuracy
    let speed: CLLocationSpeed
    let course: CLLocationDirection
    let timestamp: Date
}

extension CLLocation {
    convenience init(model: Location) {
        self.init(coordinate: CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude), altitude: model.altitude, horizontalAccuracy: model.hAccuracy, verticalAccuracy: model.vAccuracy, course: model.course, speed: model.speed, timestamp: model.timestamp)
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
        type = .photo
        self.photo = media
        
        if members.count > 0 {
            self.members = members
        }
    }
}

protocol Record: Codable {
    var type: recordType {get set}
    var members: [Member] {get set}
    init(_ members: [Member])
}

enum recordType: String, Codable, CodingKey {
    case start
    case end
    case pause
    case resume
    case route
    case photo
    case video
    case memo
}
