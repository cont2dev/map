//
//  monitor.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class Monitor {
    
    static let shared = Monitor()
    
    var timer: Timer
    var timeInterval: Double
    
    private init() {
        timer = Timer()
        timeInterval = 5.0 // Temporary for test
    }
    func startObserver() {
        // TODO: DEBUG
        print("observer started")
        MediaObserver.shared.startHooking()
    }
    
    func startMonitor() {
        // TODO: DEBUG
        print("monitor started")
        
        startObserver()
        
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: Selector(("periodTracking")), userInfo: nil, repeats: false)
    }
    
    func periodTracking() {
        TripManager.shared.periodTracking()
        
        // TODO: DEBUG
        print("Is this working?")
    }
    
    func hook(media: Media) {
        TripManager.shared.hook(media: media)
    }
    
    func stopMonitor() {
        // TODO: DEBUG
        print("monitor stopped")
        
        MediaObserver.shared.stopHooking()
    }
}
