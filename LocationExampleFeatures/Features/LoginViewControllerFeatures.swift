//
//  MapViewControllerFeatures.swift
//  LocationExample
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

@testable import LocationExample
import Nocilla

class MapViewControllerFeatures: KIFTestCase {
    override func beforeAll() {
        super.beforeAll()

        self.setRootViewController(name: "MapViewController")
    }
    override func afterEach() {
        super.afterEach()

        self.setRootViewController(name: "MapViewController")
    }

    func testPresenceOfView() {
        viewTester().usingLabel("Map View")?.waitForView()
    }
}
