//
//  File.swift
//  map
//
//  Created by Go Sangchul on 2018. 3. 20..
//  Copyright © 2018년 three idiots. All rights reserved.
//

import Foundation
import CoreLocation

protocol RecordProtocol {
    func createRecord(type:recordType, with member:[Member], media:Media?, location: CLLocation?) -> Record?
}
