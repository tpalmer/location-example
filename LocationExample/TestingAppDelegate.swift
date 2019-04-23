//
//  TestingAppDelegate.swift
//  LocationExample
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import UIKit
import RealmSwift
@testable import LocationExample

class TestingAppDelegate: NSObject {
    @objc var window: UIWindow?

    @objc func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Logic specific to functional tests goes here.

        return true
    }
}
