//
//  mediaObserver.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class MediaHooker {
    
    static let shared = MediaHooker()
    
    var isRunning: Bool
    
    // TODO: DEBUG
    var tempThreadQueue: DispatchQueue
    var tempThread: DispatchWorkItem?
    var count = 0
    
    private init() {
        isRunning = false
        tempThreadQueue = DispatchQueue(label: "hookingQueue")
        tempThread = nil
    }
    
    func hookingLoop() {
        // TODO: DEBUG
        let hookedData = self.hookMedia()
        
        sleep(5)
        DispatchQueue.main.async {
            print("hooked: \(self.count)")
        }
        
        self.count += 1
        
        Monitor.shared.hooked(media: hookedData)
    }
    
    func startHooking() {
        // TODO: DEBUG
        print("hooking started")
        
        self.tempThread = DispatchWorkItem {
            while (self.isRunning) {
                self.hookingLoop()
            }
        }
        
        if let thread = self.tempThread {
            self.isRunning = true
            tempThreadQueue.async(execute: thread)
        }
    }
    
    func stopHooking() {
        // TODO: DEBUG
        print("hooking stopped")
        if let thread = self.tempThread {
            thread.cancel()
        }

        self.isRunning = false
    }
    
    private func hookMedia() -> Media {
        return photo()
    }
}
