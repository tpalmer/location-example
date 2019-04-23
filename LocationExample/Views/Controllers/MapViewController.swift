//
//  MapViewController.swift
//  LocationExample
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2018 Travis Palmer. All rights reserved.
//

import RealmSwift
import MapKit
import Contacts

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var locationStatus = "Not Determined"

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()

        // TODO: Capture location in background
    }

    func updateLocationPins() {
        let locations = RealmManager.instance().objects(Location.self)
        for location in locations {
            let coordinate = CLLocationCoordinate2DMake(
                Double(location.latitude) ?? 0.0,
                Double(location.longitude) ?? 0.0
            )

            let locationPin = MKPointAnnotation()
            locationPin.coordinate = coordinate
            locationPin.title = location.address

            self.mapView.addAnnotation(locationPin)
        }
    }

    // MARK: CLLocationManager delegate methods START

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let clLocation = locations.last else {
            return
        }

        let location = Location()
        let coordinate = clLocation.coordinate
        location.latitude = String(coordinate.latitude)
        location.longitude = String(coordinate.longitude)

        clLocation.reverseGeocode { placemark, error in
            guard error == nil else {
                logger.error("CLError:", error?.localizedDescription ?? "")
                return
            }
            guard let placemark = placemark?.first else {
                logger.error("Unable to find placemark")
                return
            }

            let formatter = CNPostalAddressFormatter()
            formatter.style = .mailingAddress
            let mailingAddress = formatter.string(from: placemark.postalAddress ?? CNPostalAddress())

            DispatchQueue.main.async {
                RealmManager.write {
                    location.address = mailingAddress.replacingOccurrences(of: "\n", with: " ")
                }

                logger.debug("Updated location address: \(location)")
                self.updateLocationPins()
            }
        }

        RealmManager.write {
            logger.debug("Saving location: \(location)")
            RealmManager.instance().add(location)
        }

        self.updateLocationPins()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        var allowed = false

        switch status {
        case CLAuthorizationStatus.restricted:
            locationStatus = "Restricted access to location"
        case CLAuthorizationStatus.denied:
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationStatus = "Status not determined"
        default:
            locationStatus = "Allowed to access location"
            allowed = true
        }
        if allowed {
            logger.info(locationStatus)
            locationManager.startUpdatingLocation()
        } else {
            logger.error("Denied location access: \(locationStatus)")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error("Error updating location: \(error)")
    }

    // MARK: CLLocationManager delegate methods END

    // MARK: MKMapView delegate methods START

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true

        return annotationView
    }

    // MARK: MKMapView delegate methods END
}
