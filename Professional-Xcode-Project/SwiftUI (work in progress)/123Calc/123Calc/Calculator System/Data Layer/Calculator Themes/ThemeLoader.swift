//
//  ThemeLoader.swift
//  Calc123
//
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
//   It's a struct that provides access to all of the color themes.
//   Architectural Layer: Data Layer
//
// -------------------------------------------------------------------------------------------


import Foundation

struct ThemeLoader {
    var allThemes: [CalculatorTheme] {
        [appBrandTheme,
        purpleTheme,
        orangeTheme,
        pinkTheme,
        lightBlueTheme,
        electroTheme,
        washedOutTheme,
        bloodOrangeTheme,
        darkBlueTheme]
    }
}
