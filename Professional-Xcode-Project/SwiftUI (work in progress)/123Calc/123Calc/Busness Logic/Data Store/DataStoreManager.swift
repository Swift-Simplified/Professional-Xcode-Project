//
//  DataStoreManager.swift
//  123Calc
//
//  Created by SwiftSimplified.com on 23/09/2023.
//
//  SwiftSimplified.com             → All rights reserved
//  Website                         → https://www.swiftsimplified.com
//
//  We 🧡 Swift
//  Welcome to our community of Swift Simplified students!
//
//  🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
// -------------------------------------------------------------------------------------------
//
// → What's This File?
//   It's a datastore manager, a simple wrapper for User Defaults.
//   Architectural Layer: The business logic layer (the main non-visual system).
//
//   💡 Architecture Tip 👉🏻 We disconnect "how" the data is stored by creating this wrapper
//   around the UserDefaults data store.
// -------------------------------------------------------------------------------------------

import Foundation

struct DataStoreManager {
    // MARK: - Unique Key

    let key: String

    // MARK: - Storing Data

    func set(_ value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func getValue() -> Any? {
        UserDefaults.standard.object(forKey: key)
    }

    // MARK: - Deleting Data

    func deleteValue() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
