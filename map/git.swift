//
//  File.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class git
{
    static func createCommite(type:eventType, with member:[Member], media:Media? = nil) -> commit? {
        var event:commit?
        switch type {
        case .start:
            event = Start(member)
        case .route:
            event = Route(member)
        case .end:
            event = End(member)
        case .pause:
            event = Pause(member)
        case .resume:
            event = Resume(member)
        case .photo:
            event = Photo(member, media: media as! photo)
        default:
            print("\(type) is not implimented")
        }
        if let event = event {
            return event
        } else {
            return nil
        }
    }
}
