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

    
    func startObserver() {
        observer.startHooking()
    }
    func startMonitor() {
    }
    
    init() {
        observer = mediaObserver()
        timer = Timer()
    }
}
