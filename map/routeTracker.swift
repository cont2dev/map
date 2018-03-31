//
//  routeTracker.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class RouteTracker {
    
    static let shared = RouteTracker()
    
    var tracking: Bool = true
    var currentRoute: Route?
    
    // TODO: DEBUG
    var count = 0
    
    private init() {
        
    }
    
    func trackingLoop() {
        // TODO: DEBUG
        sleep(30)
        print("tracked: \(count)")
        count += 1
    }
    
    func startTracking(it event: Route) {
        // TODO: DEBUG
        print("tracking started")
        
        tracking = true
        currentRoute = event
        
        while (tracking) {
            trackingLoop()
        }
    }
    
    func stopTracking() {
        // TODO: DEBUG
        print("tracking stopped")
        
        tracking = false
        currentRoute = nil
    }
}
