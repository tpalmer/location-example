//
//  CLLocationMock.swift
//  LocationExampleTests
//
//  Created by Travis Palmer on 4/24/19.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import Foundation
import CoreLocation

class CLLocationMock: CLLocation {
    var reverseGeocodeCallCount = 0

    override func reverseGeocode(completion: @escaping (_ placemark: [CLPlacemark]?, _ error: Error?) -> Void) {
        self.reverseGeocodeCallCount += 1
    }
}
