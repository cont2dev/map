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
    static func createCommite(type:eventType, with member:[Member]) -> commit? {
        var event:commit?
        switch type {
        case .start:
            event = Start(member)
        case .route:
            event = Route(member)
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
