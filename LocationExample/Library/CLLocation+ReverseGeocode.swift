//
//  CLLocation+ReverseGeocode.swift
//  LocationExample
//
//  Created by Travis Palmer on 4/23/19.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    func reverseGeocode(
        completion: @escaping (_ placemark: [CLPlacemark]?,
        _ error: Error?) -> Void) {

        CLGeocoder().reverseGeocodeLocation(self, completionHandler: completion)
    }
}
