//
//  ThemeLoader.swift
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
//   It's a struct that provides access to all of the color themes.
//   Architectural Layer: The business logic layer (the main non-visual system).
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
