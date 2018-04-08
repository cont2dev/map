//
//  monitor.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation

class Monitor {
    
    static let shared = Monitor()
    
    private init() {
        
    }
    
    func startTracking() {
        RouteTracker.shared.startTracking()
    }
    
    func stopTracking() {
        RouteTracker.shared.stopTracking()
    }
    
    func save(location: CLLocation) {
        TripManager.shared.save(location: location)
    }

    func startHooking() {
        MediaHooker.shared.startHooking()
    }
    
    func stopHooking() {
        MediaHooker.shared.stopHooking()
    }
    
    func hooked(media: Media) {
        TripManager.shared.hooked(media: media)
    }
}
