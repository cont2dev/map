//
//  routeTracker.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation

class RouteTracker {
    static let shared = RouteTracker()
    
    var isRunning: Bool
    
    // TODO: DEBUG
    var tempThreadQueue: DispatchQueue
    var tempThread: DispatchWorkItem?
    var count = 0
    
    private init() {
        isRunning = false
        tempThreadQueue = DispatchQueue(label: "trackingQueue")
        tempThread = nil
    }
    
    func trackingLoop() {
        // TODO: DEBUG
        
        sleep(3)
        DispatchQueue.main.async {
            print("tracked: \(self.count)")
            Monitor.shared.save(location: CLLocation())
        }

        self.count += 1
    }
    
    func startTracking() {
        // TODO: DEBUG
        print("tracking started")
        self.tempThread = DispatchWorkItem {
            while (self.isRunning) {
                self.trackingLoop()
            }
        }

        if let thread = self.tempThread {
            self.isRunning = true
            tempThreadQueue.async(execute: thread)
        }
    }
    
    func stopTracking() {
        // TODO: DEBUG
        print("tracking stopped")
        if let thread = self.tempThread {
            thread.cancel()
        }
        
        self.isRunning = false
    }
}
