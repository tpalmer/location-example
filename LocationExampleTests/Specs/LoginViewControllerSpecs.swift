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
            it("initializes the map view") {
                mapVC.viewDidLoad()

                expect(mapVC.mapView).toNot(beNil())
            }
        }
    }
}
