//
//  MapViewControllerSpecs.swift
//  LocationExampleTests
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

@testable import LocationExample
import Quick
import Nimble
import Nocilla
import RealmSwift
import CoreLocation

class MapViewControllerSpecs: QuickSpec {
    override func spec() {
        super.spec()

        var mapVC: MapViewController!

        beforeEach {
            mapVC = UIStoryboard(
                name: "Main",
                bundle: nil).instantiateViewController(
                    withIdentifier: "MapViewController"
                ) as? MapViewController

            // IBOutlets are nil unless loadView() is called.
            mapVC.loadView()
        }

        describe("viewDidLoad") {
            beforeEach {
                mapVC.viewDidLoad()
            }

            it("initializes the map view") {
                expect(mapVC.mapView).toNot(beNil())
            }

            it("sets the map view delegate") {
                expect(mapVC.mapView.delegate).toNot(beNil())
            }

            it("sets the location manager delegate") {
                expect(mapVC.locationManager.delegate).toNot(beNil())
            }

            it("allows background location updates") {
                expect(mapVC.locationManager.allowsBackgroundLocationUpdates).to(beTrue())
            }

            it("does not pause location updates automatically") {
                expect(mapVC.locationManager.pausesLocationUpdatesAutomatically).to(beFalse())
            }

            it("sets the location accuracy to the best available accuracy") {
                expect(mapVC.locationManager.desiredAccuracy).to(equal(kCLLocationAccuracyBest))
            }

            it("requests Always authorization") {
                let locationManagerMock = CLLocationManagerMock()
                mapVC.locationManager = locationManagerMock

                mapVC.viewDidLoad()

                expect(locationManagerMock.requestAlwaysAuthorizationCallCount).to(equal(1))
            }
        }
    }
}
