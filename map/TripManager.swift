//
//  tripManager.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 13..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation

class TripManager: RecordProtocol {
    
    static let shared = TripManager()
    
    var trips = [Trip]()
    var currentTrip: Trip?
    
    private init() {
        
    }
    
    func createRecord(type: recordType, with member: [Member], media: Media?, location: CLLocation?) -> Record? {
        switch type {
        case .start:
            return Start(member)
        case .route:
            return Route(member, location!)
        case .end:
            return End(member)
        case .pause:
            return Pause(member)
        case .resume:
            return Resume(member)
        case .photo:
            return Photo(member, media: media as! photo)
        default:
            print("\(type) is not implimented")
            return nil
        }
    }

    func createRecord(_ type:recordType, media:Media? = nil, location: CLLocation? = nil) -> Record? {
        return createRecord(type: type, with: (currentTrip?.member)!, media: media, location: location)
    }

    func save(record: Record) {
        if let trip = currentTrip {
            trip.history.append(record)
            
            // TODO: DEBUG
            print("\(trip.history)")
        }
    }
    
    func startMonitor() {
        Monitor.shared.startTracking()
        Monitor.shared.startHooking()
    }
    
    func stopMonitor() {
        Monitor.shared.stopTracking()
        Monitor.shared.stopHooking()
    }
    
    func save(location: CLLocation) {
        if let record = createRecord(.route, location: location) {
            save(record: record)
        }
    }

    func hooked(media: Media) {
        if media is photo {
            if let record = createRecord(.photo, media: media) {
                save(record: record)
            }
        }
    }
    
    func startTrip() {
        let defaultMember = Member(name: "default user", address: "email")
        let trip = Trip(with:defaultMember)
        
        // TODO: DEBUG
        print("trip started")
        
        trips.append(trip)
        currentTrip = trip
        
        if let record = createRecord(.start) {
            save(record: record)
            currentTrip?.status = .traveling
        }
        
        startMonitor()
    }
    
    func endTrip() {
        // TODO: DEBUG
        print("trip ended")
        
        stopMonitor()
        
        if let record = createRecord(.end) {
            save(record: record)
            currentTrip?.status = .idle
        }
    }
    
    func pauseTrip() {
        // TODO: DEBUG
        print("trip paused")
        
        if let record = createRecord(.pause) {
            save(record: record)
            stopMonitor()
            currentTrip?.status = .idle
        }
    }
    
    func resumeTrip() {
        // TODO: DEBUG
        print("trip resumed")
        
        if let record = createRecord(.resume) {
            save(record: record)
            startMonitor()
            currentTrip?.status = .traveling
        }
    }
}
