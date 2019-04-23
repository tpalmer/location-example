//
//  RealmManager.swift
//  LocationExample
//
//  Created by Travis Palmer on 9/6/18.
//  Copyright © 2019 Travis Palmer. All rights reserved.
//

import RealmSwift

class RealmManager {
    public class func instance() -> Realm {
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        return realm
    }

    public class func write(block: @escaping () -> Void) {
        // swiftlint:disable:next force_try
        let realm = try! Realm()
        // swiftlint:disable:next force_try
        try! realm.write {
            block()
        }
    }
}
