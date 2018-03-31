//
//  mediaObserver.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class MediaObserver {
    
    static let shared = MediaObserver()
    
    var observe: Bool
    
    // TODO: DEBUG
    var count = 0
    
    init() {
        observe = true
    }
    
    func startHooking() {
        while (observe) {
            let hookedData = hookMedia()
            
            // TODO: DEBUG
            sleep(20)
            print("hooked: \(count)")
            count += 1
            Monitor.shared.hook(media: hookedData)
        }
    }
    
    private func hookMedia() -> Media {
        return photo()
    }
    
    func stopHooking() {
        observe = false
    }
}
