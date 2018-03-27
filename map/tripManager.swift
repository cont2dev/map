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
    
    func createStartCommit() {
        currentEvent = git.createCommite(type: .start, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
    }
    
    func createRouteCommit() {
        currentEvent = git.createCommite(type: .route, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
    }

    func createPhotoCommit(photo:photo) {
        currentEvent = git.createCommite(type: .photo, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
    }

    func createResumeCommit() {
        currentEvent = git.createCommite(type: .resume, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
    }
    
    func createEndCommit() {
        currentEvent = git.createCommite(type: .end, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
    }
    
    func createPauseCommit() {
        currentEvent = git.createCommite(type: .pause, with: (currentTrip?.member)!)
        currentTrip?.commitList.append(currentEvent!)
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
        createRouteCommit()
        
        if let event = currentEvent {
            tracker.startTrcking(it: event as! Route)
            monitor.startMonitor()
        }
    }

    func hook(media:Media) {
        tracker.stopTracking()
        
        if media is photo {
            createPhotoCommit(photo: media as! photo)
        }
        
        createRouteCommit()
        startTracking()
    }
    
    func startTrip() {
        let defaultMember = Member(name: "default user", address: "email")
        let trip = Trip(with:defaultMember)
        trips.append(trip)
        currentTrip = trip
        createStartCommit()
        startTracking()
    }
    
    func endTrip() {
        monitor.stopMonitor()
        tracker.stopTracking()
        createEndCommit()
    }
    
    func pauseTrip() {
        monitor.stopMonitor()
        tracker.stopTracking()
        createPauseCommit()
    }
    
    func resumeTrip() {
        createResumeCommit()
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
