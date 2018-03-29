//
//  File.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation

protocol gitProtocol {
    func createCommit(type:eventType, with member:[Member], media:Media?) -> commit?
}
