//
//  MapViewController.swift
//  LocationExample
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2018 Travis Palmer. All rights reserved.
//

import RealmSwift
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        let centerCoordinate = CLLocationCoordinate2DMake(
//            Double(reading.latitude) ?? 0.0,
//            Double(reading.longitude) ?? 0.0
//        )
//        let region = MKCoordinateRegion(
//            center: centerCoordinate,
//            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        )
//        let locationPin = MKPointAnnotation()
//        locationPin.coordinate = centerCoordinate
//        self.mapView.addAnnotation(locationPin)
//        self.mapView.setRegion(region, animated: true)
    }
}
