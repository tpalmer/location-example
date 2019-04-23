//
//  CLLocationManagerMock.swift
//  LocationExampleTests
//
//  Created by Travis Palmer on 9/7/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

@testable import LocationExample
import CoreLocation

class CLLocationManagerMock: CLLocationManager {
    var requestAlwaysAuthorizationCallCount = 0
    var requestWhenInUseAuthorizationCallCount = 0

    override func requestAlwaysAuthorization() {
        self.requestAlwaysAuthorizationCallCount += 1
    }

    override func requestWhenInUseAuthorization() {
        self.requestWhenInUseAuthorizationCallCount += 1
    }
}
