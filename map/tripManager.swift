//
//  tripManager.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 13..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class TripManager: gitProtocol {
    
    /*
     * TODO: implementaion MULTI THREADING
     */
    
    static let shared = TripManager()
    
    var trips = [Trip]()
    var currentTrip:Trip?
    var currentEvent:commit?
    
    private init() {
        
    }
    
    func createCommit(type: eventType, with member: [Member], media: Media?) -> commit? {
        let event: commit?
        
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

    func createCommit(_ event:eventType, media:Media? = nil) -> commit? {
        return createCommit(type: event, with: (currentTrip?.member)!, media: media)
    }
    
    func pushCommit(_ commit:commit) {
        if let trip = currentTrip {
            trip.commitList.append(commit)
        }
    }
    
    func startTracking() {
        currentEvent = createCommit(.route)
        if let event = currentEvent {
            pushCommit(event)
        }
        
        if let event = currentEvent {
            Monitor.shared.startMonitor()
            RouteTracker.shared.startTracking(it: event as! Route)
        }
    }
    
    func stopTracking() {
        Monitor.shared.stopMonitor()
        RouteTracker.shared.stopTracking()
    }
    
    func periodTracking() {
        
    }

    func hook(media: Media) {
        stopTracking()
        
        if media is photo {
            currentEvent = createCommit(.photo, media: media)
            if let event = currentEvent {
                pushCommit(event)
            }
        }

        currentEvent = createCommit(.route)
        if let event = currentEvent {
            pushCommit(event)
        }
        
        startTracking()
    }
    
    func startTrip() {
        let defaultMember = Member(name: "default user", address: "email")
        let trip = Trip(with:defaultMember)
        
        // TODO: DEBUG
        print("trip started")
        
        trips.append(trip)
        currentTrip = trip
        
        currentEvent = createCommit(.start)
        if let event = currentEvent {
            pushCommit(event)
        }
        
        startTracking()
    }
    
    func endTrip() {
        // TODO: DEBUG
        print("trip ended")
        
        Monitor.shared.stopMonitor()
        RouteTracker.shared.stopTracking()
        
        currentEvent = createCommit(.end)
        
        if let event = currentEvent {
            pushCommit(event)
        }
    }
    
    func pauseTrip() {
        // TODO: DEBUG
        print("trip paused")
        
        currentEvent = createCommit(.pause)
        if let event = currentEvent {
            pushCommit(event)
            stopTracking()
        }
    }
    
    func resumeTrip() {
        // TODO: DEBUG
        print("trip resumed")
        
        currentEvent = createCommit(.resume)
        
        if let event = currentEvent {
            pushCommit(event)
            startTracking()
        }
    }
}
