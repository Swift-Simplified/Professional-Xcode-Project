//
//  Constants.swift
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
//   It's a centralised area to store values. Here we can store a list of constant values
//   that we don't want to repeat or duplicate throughout our codebase.
//
// -------------------------------------------------------------------------------------------

import Foundation
import UIKit

// MARK: - ThemeManager

extension ThemeManager {
    enum keys {
        static let dataStore = "swiftsimplified.com.calc.ThemeManager.theme"
    }
}

// MARK: - Calculator

extension Calculator {
    enum keys {
        static let dataStore = "swiftsimplified.com.calc.CalculatorEngine.total"
    }
}
