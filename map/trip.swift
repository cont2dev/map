//
//  trip.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 6..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

class Trip {
    var name:String
    //var status:tripStatus = .idle
    var member = [Member]()
    var commitList = [commit]()
    
    init(withName name:String = "default trip", with member:Member) {
        self.name = name
        self.member.append(member)
    }
}

enum tripStatus {
    case plan
    case traveling
    case idle
    case garbage
}

struct location {
}

struct Member
{
    let name:String
    var address:String
}
