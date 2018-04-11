//
//  tripManager.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 13..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class TripManager: RecordProtocol {
    
    static let shared = TripManager()
    
    var trips = [Trip]()
    var currentTrip: Trip?
    
    private init() {
        
    }
    
    func createRecord(type: recordType, with member: [Member], media: Media?, location: CLLocation?) -> Record? {
        switch type {
        case .start:
            return Start(member)
        case .route:
            return Route(member, location!)
        case .end:
            return End(member)
        case .pause:
            return Pause(member)
        case .resume:
            return Resume(member)
        case .photo:
            return Photo(member, media: media as! photo)
        default:
            print("\(type) is not implimented")
            return nil
        }
    }

    func createRecord(_ type:recordType, media:Media? = nil, location: CLLocation? = nil) -> Record? {
        return createRecord(type: type, with: (currentTrip?.member)!, media: media, location: location)
    }

    func save(record: Record) {
        if let trip = currentTrip {
            trip.history.append(record)
            
            // TODO: DEBUG
            print("\(trip.history)")
        }
    }
    
    func startMonitor() {
        Monitor.shared.startTracking()
        Monitor.shared.startHooking()
    }
    
    func stopMonitor() {
        Monitor.shared.stopTracking()
        Monitor.shared.stopHooking()
    }
    
    func save(location: CLLocation) {
        if currentTrip != nil {
            if let record = createRecord(.route, location: location) {
                save(record: record)
                viewController?.save(location: location.coordinate)
            }
        }
    }

    func hooked(media: Media) {
        if currentTrip != nil {
            if media is photo {
                if let record = createRecord(.photo, media: media) {
                    save(record: record)
                }
            }
        }
    }
    
    // TODO: viewcontroller shuold be removed.
    var viewController: ViewController?
    
    func startTrip(viewController: ViewController) {
        let defaultMember = Member(name: "default user", address: "email")
        let trip = Trip(withName: "\(Date()).json", with: defaultMember)
        // TODO: DEBUG
        print("trip started")
        
        trips.append(trip)
        currentTrip = trip
        
        if let record = createRecord(.start) {
            save(record: record)
            currentTrip?.status = .traveling
        }
        self.viewController = viewController
        startMonitor()
    }
    
    func endTrip() {
        // TODO: DEBUG
        print("trip ended")
        
        stopMonitor()
        
        if let record = createRecord(.end) {
            save(record: record)
            currentTrip?.status = .idle
        }
        saveByJson()
        currentTrip = nil
    }
    
    enum Directory {
        // Only documents and other data that is user-generated, or that cannot otherwise be recreated by your application, should be stored in the <Application_Home>/Documents directory and will be automatically backed up by iCloud.
        case documents
        
        // Data that can be downloaded again or regenerated should be stored in the <Application_Home>/Library/Caches directory. Examples of files you should put in the Caches directory include database cache files and downloadable content, such as that used by magazine, newspaper, and map applications.
        case caches
    }

    fileprivate func getURL(for directory: Directory) -> URL {
        var searchPathDirectory: FileManager.SearchPathDirectory
        
        switch directory {
        case .documents:
            searchPathDirectory = .documentDirectory
        case .caches:
            searchPathDirectory = .cachesDirectory
        }
        
        if let url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not create URL for specified directory!")
        }
    }
    
    private func saveByJson() {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(currentTrip)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            
            let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last! as NSURL

            //let url = getURL(for: .documents).appendingPathComponent((currentTrip?.name)!, isDirectory: false)
            let url = localDocumentsURL.appendingPathComponent((currentTrip?.name)!)

            
            if FileManager.default.fileExists(atPath: url!.path) {
                try FileManager.default.removeItem(at: url!)
            }
            _ = try jsonString?.write(to: url!, atomically: true, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            //FileManager.default.createFile(atPath: url!.path, contents: jsonData, attributes: nil)
            
            // TODO: should test.
            let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent((currentTrip?.name)!)
            
            if iCloudDocumentsURL != nil {
                //Create the Directory if it doesn't exist
                if (!FileManager.default.fileExists(atPath: iCloudDocumentsURL!.path, isDirectory: nil)) {
                    //This gets skipped after initial run saying directory exists, but still don't see it on iCloud
                    try FileManager.default.createDirectory(at: iCloudDocumentsURL!, withIntermediateDirectories: true, attributes: nil)
                }
                
                var isDir:ObjCBool = false
                if (FileManager.default.fileExists(atPath: iCloudDocumentsURL!.path, isDirectory: &isDir)) {
                    try FileManager.default.removeItem(at: iCloudDocumentsURL!)
                }
                
                try FileManager.default.copyItem(at: url!, to: iCloudDocumentsURL!)
            } else {
                print("iCloud is NOT working!")
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func copyDocumentsToiCloudDrive() {
        var error: NSError?
        let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent((currentTrip?.name)!)
        
        do{
            //is iCloud working?
            if  iCloudDocumentsURL != nil {
                //Create the Directory if it doesn't exist
                if (!FileManager.default.fileExists(atPath: iCloudDocumentsURL!.path, isDirectory: nil)) {
                    //This gets skipped after initial run saying directory exists, but still don't see it on iCloud
                    try FileManager.default.createDirectory(at: iCloudDocumentsURL!, withIntermediateDirectories: true, attributes: nil)
                }
            } else {
                print("iCloud is NOT working!")
                //  return
            }
            
            if error != nil {
                print("Error creating iCloud DIR")
            }
            
            //Set up directorys
            let localDocumentsURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last! as NSURL
            
            //Add txt file to my local folder
            let myTextString = NSString(string: "HELLO WORLD")
            let myLocalFile = localDocumentsURL.appendingPathComponent("myTextFile.txt")
            _ = try myTextString.write(to: myLocalFile!, atomically: true, encoding: String.Encoding.utf8.rawValue)
            
            if ((error) != nil){
                print("Error saving to local DIR")
            }
            
            //If file exists on iCloud remove it
            var isDir:ObjCBool = false
            if (FileManager.default.fileExists(atPath: iCloudDocumentsURL!.path, isDirectory: &isDir)) {
                try FileManager.default.removeItem(at: iCloudDocumentsURL!)
            }
            
            //copy from my local to iCloud
            if error == nil {
                try FileManager.default.copyItem(at: localDocumentsURL as URL, to: iCloudDocumentsURL!)
            }
        }
        catch{
            print("Error creating a file")
        }
    }
    
    func pauseTrip() {
        // TODO: DEBUG
        print("trip paused")
        
        if let record = createRecord(.pause) {
            save(record: record)
            stopMonitor()
            currentTrip?.status = .idle
        }
    }
    
    func resumeTrip() {
        // TODO: DEBUG
        print("trip resumed")
        
        if let record = createRecord(.resume) {
            save(record: record)
            startMonitor()
            currentTrip?.status = .traveling
        }
    }
}
