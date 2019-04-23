//
//  Location.swift
//  LocationExample
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

class Location: Object {
    @objc dynamic var latitude = ""
    @objc dynamic var longitude = ""
    @objc dynamic var address = ""
}
