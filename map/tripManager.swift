//
//  tripManager.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 13..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class TripManager
{
    var trips = [Trip]()
    var currentTrip:Trip?
    var currentEvent:commit?
    
    var tracker:routeTracker
    let monitor:Monitor
    
    func createCommit(_ event:eventType, media:Media? = nil) {
        currentEvent = git.createCommite(type: event, with: (currentTrip?.member)!, media: media)
        if var trip = currentTrip {
            if let event = currentEvent {
                trip.commitList.append(event)
            }
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
        createCommit(.route)
        
        if let event = currentEvent {
            tracker.startTrcking(it: event as! Route)
            monitor.startMonitor()
        }
    }

    func hook(media:Media) {
        tracker.stopTracking()
        
        if media is photo {
            createCommit(.photo, media: media)
        }

        createCommit(.route)
        startTracking()
    }
    
    func startTrip() {
        let defaultMember = Member(name: "default user", address: "email")
        let trip = Trip(with:defaultMember)
        trips.append(trip)
        currentTrip = trip
        createCommit(.start)
        startTracking()
    }
    
    func endTrip() {
        monitor.stopMonitor()
        tracker.stopTracking()
        createCommit(.end)
    }
    
    func pauseTrip() {
        monitor.stopMonitor()
        tracker.stopTracking()
        createCommit(.pause)
    }
    
    func resumeTrip() {
        createCommit(.resume)
        if let event = currentEvent {
            tracker.startTrcking(it: event as! Route)
            monitor.startMonitor()
        }
    }
    
    init() {
        tracker = routeTracker()
        monitor = Monitor()
        monitor.tripManager = self
    }
}
