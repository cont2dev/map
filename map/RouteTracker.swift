//
//  routeTracker.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation

class RouteTracker: NSObject, CLLocationManagerDelegate {
    static let shared = RouteTracker()
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations {
            print("\(index): \(currentLocation)")
        }
        Monitor.shared.save(location:locations.last!)
    }
    
    func startTracking() {
        // TODO: DEBUG
        print("tracking started")
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.distanceFilter = 10
    }
    
    func stopTracking() {
        // TODO: DEBUG
        print("tracking stopped")
        locationManager.stopUpdatingLocation()
    }
}
