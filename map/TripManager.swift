//
//  tripManager.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 13..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class TripManager: RecordProtocol {
    
    static let shared = TripManager()
    
    var trips = [Trip]()
    var currentTrip: Trip?
    var currentEvent: Record?
    
    private init() {
        
    }
    
    func createRecord(type: eventType, with member: [Member], media: Media?) -> Record? {
        let event: Record?
        
        event = {
            switch type {
            case .start:
                return Start(member)
            case .route:
                return Route(member)
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
        } ()
        
        return event
    }

    func createRecord(_ event:eventType, media:Media? = nil) -> Record? {
        return createRecord(type: event, with: (currentTrip?.member)!, media: media)
    }
    
    func saveRecord(_ record: Record) {
        if let trip = currentTrip {
            trip.history.append(record)
            
            // TODO: DEBUG
            print("\(trip.history)")
        }
    }
    
    func startMonitor() {
        currentEvent = createRecord(.route)
        
        if let event = currentEvent {
            saveRecord(event)
            
            Monitor.shared.startTracking(routeRecord: event as! Route)
            Monitor.shared.startHooking()
        }
    }
    
    func stopMonitor() {
        Monitor.shared.stopTracking()
        Monitor.shared.stopHooking()
    }

    func hooked(media: Media) {
        stopMonitor()
        
        if media is photo {
            currentEvent = createRecord(.photo, media: media)
            if let event = currentEvent {
                saveRecord(event)
            }
        }
        
        startMonitor()
    }
    
    func startTrip() {
        let defaultMember = Member(name: "default user", address: "email")
        let trip = Trip(with:defaultMember)
        
        // TODO: DEBUG
        print("trip started")
        
        trips.append(trip)
        currentTrip = trip
        
        currentEvent = createRecord(.start)
        if let event = currentEvent {
            saveRecord(event)
        }
        
        startMonitor()
    }
    
    func endTrip() {
        // TODO: DEBUG
        print("trip ended")
        
        stopMonitor()
        
        currentEvent = createRecord(.end)
        
        if let event = currentEvent {
            saveRecord(event)
        }
    }
    
    func pauseTrip() {
        // TODO: DEBUG
        print("trip paused")
        
        currentEvent = createRecord(.pause)
        if let event = currentEvent {
            saveRecord(event)
            stopMonitor()
        }
    }
    
    func resumeTrip() {
        // TODO: DEBUG
        print("trip resumed")
        
        currentEvent = createRecord(.resume)
        
        if let event = currentEvent {
            saveRecord(event)
            startMonitor()
        }
    }
}
