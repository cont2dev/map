//
//  routeTracker.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class routeTracker
{
    var tracking:Bool = true
    var currentRoute:Route?
    
    func trackingLoop() {
        
    }
    
    func startTrcking(it event:Route)
    {
        tracking = true
        currentRoute = event
        while (tracking) {
            trackingLoop()
        }
    }
    
    func stopTracking() {
        tracking = false
    }
}
