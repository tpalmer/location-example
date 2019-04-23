//
//  XCTestCaseExtension.swift
//  LocationExampleTests
//
//  Created by Travis Palmer on 8/21/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import XCTest
import RealmSwift
import Nocilla

extension XCTestCase {
    override open func setUp() {
        super.setUp()

        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name

        LSNocilla.sharedInstance().start()
        self.defineGlobalStubs()
    }

    func defineGlobalStubs () {
        stubRequest("GET", "https://static.realm.io".regex())
    }
}
