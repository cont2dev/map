//
//  monitor.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class Monitor
{
    var timer:Timer
    let observer:mediaObserver
    var timeInterval:Double
    var tripManager:TripManager?
    
    func startObserver() {
        observer.startHooking()
    }
    
    func startMonitor() {
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: Selector(("stopTracking")), userInfo: nil, repeats: false)
    }
    
    func stopTracking() {
        if let tripManager = tripManager {
            tripManager.stopTracking()
        }
    }
    
    func hook(media: Media) {
        if let tripManager = tripManager {
            tripManager.hook(media: media)
        }
    }
    
    func stopMonitor() {
        observer.stopHooking()
    }
    
    init() {
        observer = mediaObserver()
        timer = Timer()
        timeInterval = 60.0
        observer.monitor = self
    }
}
