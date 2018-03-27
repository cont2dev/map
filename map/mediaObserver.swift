//
//  mediaObserver.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class mediaObserver
{
    var monitor:Monitor? = nil
    var observe:Bool
    
    init() {
        observe = true
    }
    
    func startHooking() {
        while (observe) {
            let hookedData = hookMedia()
            
            monitor?.hook(media: hookedData)
        }
    }
    
    private func hookMedia() -> Media {
        return photo()
    }
    
    func stopHooking() {
        observe = false
    }
}
