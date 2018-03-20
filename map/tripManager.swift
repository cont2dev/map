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
    let observer:mediaObserver
    let monitor:Monitor
    
    func startCommit() {
        currentEvent = git.createCommite(type: .start, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
    }
    
    func startTracking() {
        currentEvent = git.createCommite(type: .route, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
        
        if let event = currentEvent {
            tracker.startTrcking(it: event as! Route)
        }
        
        monitor.startMonitor()
    }
    
    func startTrip() {
        let defaultMember = Member(name: "default user", address: "email")
        let trip = Trip(with:defaultMember)
        trips.append(trip)
        currentTrip = trip
        
        startCommit()
        
        startTracking()
        
        observer.startHooking()
    }
    
    init() {
        tracker = routeTracker()
        observer = mediaObserver()
        monitor = Monitor()
    }
}
