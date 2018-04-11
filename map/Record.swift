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
    static var type: recordType = .start
    
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Route: Record, Codable {
    static var type: recordType = .route
    
    var members = [Member]()
    var location: CLLocation?
    
    required init(_ members: [Member]) {
        location = nil

        if members.count > 0 {
            self.members = members
        }
    }
    
    init (_ members: [Member], _ location: CLLocation) {
        if members.count > 0 {
            self.members = members
        }
        
        self.location = location
    }
    
    enum CodingKeys: String, CodingKey {
        case members
        case location
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
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
    static var type: recordType = .end
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Pause: Record {
    static var type: recordType = .pause
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Resume: Record {
    static var type: recordType = .resume
    var members = [Member]()
    let time: Date
    
    required init(_ members: [Member]) {
        time = Date()
        
        if members.count > 0 {
            self.members = members
        }
    }
}

class Photo: Record {
    static var type: recordType = .photo
    var members = [Member]()
    var photo: photo?
    
    required init(_ members: [Member]) {
        self.photo = nil
        
        if members.count > 0 {
            self.members = members
        }
    }

    init(_ members: [Member], media: photo) {
        self.photo = media
        
        if members.count > 0 {
            self.members = members
        }
    }
}

protocol Record: Codable {
    static var type: recordType {get set}
    var members: [Member] {get set}
    init(_ members: [Member])
}

struct AnyRecord: Codable {
    var base: Record
    init(_ base: Record) {
        self.base = base
    }
    
    private enum CodingKeys: CodingKey {
        case type, base
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let type = try container.decode(recordType.self, forKey: .type)
        self.base = try type.metatype.init(from: container.superDecoder(forKey: .base))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(type(of: base).type, forKey: .type)
        try base.encode(to: container.superEncoder(forKey: .base))
    }
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
    
    var metatype: Record.Type {
        switch self {
        case .start: return Start.self
        case .end: return End.self
        case .pause: return Pause.self
        case .resume: return Resume.self
        case .route: return Route.self
        case .photo: return Photo.self
        // unused behind.
        case .video: return Photo.self
        case .memo: return Photo.self
        }
    }
}
