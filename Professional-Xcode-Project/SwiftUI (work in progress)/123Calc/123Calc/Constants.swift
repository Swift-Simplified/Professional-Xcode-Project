//
//  Constants.swift
//  Calc123
//
//  Swift Simplified .com
//  Created by Matthew Harding (Swift engineer & online instructor) on 24/01/2023
//
//  Matthew Harding                 → All rights reserved
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

// MARK: - LCDDisplay

//extension LCDDisplay {
//    enum keys {
//        static let pasteNumberNotification = "swiftsimplified.com.calc.LCDDisplay.pasteNumber"
//        static let pasteEquationNotification = "swiftsimplified.com.calc.LCDDisplay.pasteMathEquation"
//        static let userInfo = "valueToPaste"
//        static let historyLogNotification = "swiftsimplified.com.calc.LCDDisplay.displayHistory"
//    }
//}

// MARK: - UIStoryboard

//extension UIStoryboard {
//    enum keys {
//        static let mainStoryboard = "Main"
//        static let logViewController = "LogViewController"
//    }
//}

// MARK: - UIImage

//extension UIImage {
//    enum keys {
//        static let button = "Button Square Rounded"
//        static let buttonSliced = "Button Square Rounded-Sliced"
//    }
//}

// MARK: - ThemeManager

extension ThemeManager {
    enum keys {
        static let dataStore = "swiftsimplified.com.calc.ThemeManager.theme"
    }
}

// MARK: - Calc123Engine

extension Calc123Engine {
    enum keys {
        static let dataStore = "swiftsimplified.com.calc.CalculatorEngine.total"
    }
}
