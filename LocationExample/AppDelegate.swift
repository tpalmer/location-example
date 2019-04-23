//
//  AppDelegate.swift
//  LocationExample
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyBeaver

let logger = SwiftyBeaver.self

class AppDelegate: UIResponder, UIApplicationDelegate {

    @objc var window: UIWindow?
    let currentSchemaVersion: UInt64 = 1

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        BuddyBuildSDK.setup()
        self.configureLogger()
        self.configureRealm()

        let realmDBLocation = Realm.Configuration.defaultConfiguration.fileURL ?? URL(fileURLWithPath: "")
        logger.info("Realm DB: \(realmDBLocation)")

        #if DEBUG
            logger.debug("************Debug mode*************")
        #else
            logger.debug("************Release mode*************")
        #endif

        return true
    }

    func configureLogger() {
        // log to Xcode console
        let console = ConsoleDestination()

        // Log levels:
        // Verbose
        // Debug
        // Info
        // Warning
        // Error
        console.minLevel = .debug
        #if DEBUG
        console.useNSLog = true
        #endif

        logger.addDestination(console)
    }

    func configureRealm() {
        // Pulled directly from the Realm documentation:
        // https://realm.io/docs/swift/latest/#local-migrations

        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: self.currentSchemaVersion,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { _, oldSchemaVersion in

                logger.info("Migrating Realm from version \(oldSchemaVersion) to version \(self.currentSchemaVersion)")
                if oldSchemaVersion < 1 {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            }
        )

        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
}
