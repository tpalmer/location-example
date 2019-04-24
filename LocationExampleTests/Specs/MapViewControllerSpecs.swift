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

        describe("updateLocationPins") {
            beforeEach {
                let location1 = Location(value: [
                    "latitude": "12",
                    "longitude": "40"
                ])
                let location2 = Location(value: [
                    "latitude": "42",
                    "longitude": "60"
                ])
                let location3 = Location(value: [
                    "latitude": "10",
                    "longitude": "60"
                ])

                RealmManager.write {
                    RealmManager.instance().add(location1)
                    RealmManager.instance().add(location2)
                    RealmManager.instance().add(location3)
                }
            }

            it("adds annotations to the mapView") {
                mapVC.updateLocationPins()

                expect(mapVC.mapView.annotations.count).to(equal(3))
            }
        }

        context("CLLocationManager delegate methods") {
            describe("locationManagerDidUpdateLocations") {
                it("reverse geocodes the passed in location addresses") {
                    let clLocation = CLLocationMock(latitude: 37.33233141, longitude: -122.0312186)
                    mapVC.locationManager(mapVC.locationManager, didUpdateLocations: [clLocation])

                    expect(clLocation.reverseGeocodeCallCount).to(equal(1))
                }
            }

            describe("locationManagerDidChangeAuthorization") {
                it("calls startUpdatingLocation if authorized") {
                    let locationManagerMock = CLLocationManagerMock()
                    mapVC.locationManager = locationManagerMock

                    mapVC.locationManager(
                        mapVC.locationManager,
                        didChangeAuthorization: CLAuthorizationStatus.authorizedAlways
                    )

                    expect(locationManagerMock.startUpdatingLocationCallCount).to(equal(1))
                }

                it ("does nothing if not authorized") {
                    let locationManagerMock = CLLocationManagerMock()
                    mapVC.locationManager = locationManagerMock

                    mapVC.locationManager(
                        mapVC.locationManager,
                        didChangeAuthorization: CLAuthorizationStatus.denied
                    )

                    expect(locationManagerMock.startUpdatingLocationCallCount).to(equal(0))
                }
            }
        }
    }
}
