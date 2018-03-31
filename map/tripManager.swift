//
//  tripManager.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 13..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class TripManager: gitProtocol
{
    static let getManager = TripManager()
    
    private init() {
        tracker = routeTracker()
        monitor = Monitor()
        monitor.tripManager = self
    }

    var trips = [Trip]()
    var currentTrip:Trip?
    var currentEvent:commit?
    
    var tracker:routeTracker
    let monitor:Monitor
    
    func createCommit(type:eventType, with member:[Member], media:Media? = nil) -> commit? {
        var event:commit?
        switch type {
        case .start:
            event = Start(member)
        case .route:
            event = Route(member)
        case .end:
            event = End(member)
        case .pause:
            event = Pause(member)
        case .resume:
            event = Resume(member)
        case .photo:
            event = Photo(member, media: media as! photo)
        default:
            print("\(type) is not implimented")
        }
        if let event = event {
            return event
        } else {
            return nil
        }
    }

    func createCommit(_ event:eventType, media:Media? = nil) -> commit? {
        return createCommit(type: event, with: (currentTrip?.member)!, media: media)
    }
    
    func pushCommit(_ commit:commit) {
        if var trip = currentTrip {
            trip.commitList.append(commit)
        }
    }
    
    func startTracking() {
        monitor.startObserver()
        createRouteNStartMonitor()
    }
    
    func periodTracking() {
        tracker.stopTracking()
        createRouteNStartMonitor()
    }
    
    func createRouteNStartMonitor() {
        currentEvent = createCommit(.route)
        if let event = currentEvent {
            pushCommit(event)
        }
        
        if let event = currentEvent {
            tracker.startTrcking(it: event as! Route)
            monitor.startMonitor()
        }
    }

    func hook(media:Media) {
        tracker.stopTracking()
        
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
        trips.append(trip)
        currentTrip = trip
        currentEvent = createCommit(.start)
        if let event = currentEvent {
            pushCommit(event)
        }
        startTracking()
    }
    
    func endTrip() {
        monitor.stopMonitor()
        tracker.stopTracking()
        currentEvent = createCommit(.end)
        if let event = currentEvent {
            pushCommit(event)
        }
    }
    
    func pauseTrip() {
        monitor.stopMonitor()
        tracker.stopTracking()
        currentEvent = createCommit(.pause)
        if let event = currentEvent {
            pushCommit(event)
        }
    }
    
    func resumeTrip() {
        currentEvent = createCommit(.resume)
        if let event = currentEvent {
            pushCommit(event)
            tracker.startTrcking(it: event as! Route)
            monitor.startMonitor()
        }
    }
}
