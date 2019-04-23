//
//  User.swift
//  LocationExample
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

class User: Object {

    // swiftlint:disable:next identifier_name
    @objc dynamic var id = ""
    @objc dynamic var currentLatitude = ""
    @objc dynamic var currentLongitude = ""
    @objc dynamic var currentCoordinate = ""

    internal static var current: User? {
        let realm = RealmManager.instance()
        return realm.objects(User.self).first
    }

    override static func primaryKey() -> String? {
        return "id"
    }

    func updateCurrentLocation(
        success: @escaping () -> Void,
        failure: @escaping (_ error: Error) -> Void) {

        let desiredAccuracy: CLLocationAccuracy? = kCLLocationAccuracyBestForNavigation

//        LocationManager.sharedManager.getCurrentLocation(desiredAccuracy: desiredAccuracy).done { location in
//            let latitude = location.coordinate.latitude
//            let longitude = location.coordinate.longitude
//            let coordinate = "POINT(\(longitude) \(latitude))"
//
//            RealmManager.write {
//                self.currentLatitude = String(latitude)
//                self.currentLongitude = String(longitude)
//                self.currentCoordinate = coordinate
//            }
//            logger.info("Updated Current Coordinate: \(coordinate)")
//
//            success()
//        }.catch { error in
//            logger.error("error updating current location: \(error)")
//
//            failure(error)
//        }
    }
}
