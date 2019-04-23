//
//  XCTestCaseExtension.swift
//  LocationExampleUITests
//
//  Created by Travis Palmer on 8/20/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

@testable import LocationExample
import XCTest
import KIF
import Nocilla
import RealmSwift

extension XCTestCase {
    override open func setUp() {
        super.setUp()

        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name + NSUUID().uuidString

        LSNocilla.sharedInstance().start()
        self.defineGlobalStubs()
    }

    func defineGlobalStubs () {
        stubRequest("GET", "https://static.realm.io".regex())
    }

    func viewTester(_ file: String = #file, _ line: Int = #line) -> KIFUIViewTestActor {
        return KIFUIViewTestActor(inFile: file, atLine: line, delegate: self)
    }

    func system(_ file: String = #file, _ line: Int = #line) -> KIFSystemTestActor {
        return KIFSystemTestActor(inFile: file, atLine: line, delegate: self)
    }

    public func setRootViewController(name: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationVC = storyboard.instantiateInitialViewController() as? UINavigationController else {
            XCTAssert(false, "expected UINavigationController for initial view controller")
            return
        }
        let initialVC = storyboard.instantiateViewController(withIdentifier: name)

        navigationVC.viewControllers = [initialVC]
        UIApplication.shared.keyWindow!.rootViewController = navigationVC
    }
}
