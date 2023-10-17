//
//  ElectroTheme.swift
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
//   It's a color theme, used to display a different color theme.
//   Architectural Layer: The business logic layer (the main non-visual system).
//
//   💡 Convenience Tip 👉🏻 We used extensions to seperate themes into seperate files providing
//   designers with editable documents. Also allowing us to conveniently load the theme array.
// -------------------------------------------------------------------------------------------

import Foundation

extension ThemeLoader {
    var electroTheme: CalculatorTheme {
        CalculatorTheme(id: "2",
                        background: "#0E0E41",
                        display: "#ffffff",
                        operatorNormal: "#4BE6A9",
                        operatorSelected: "#70729D",
                        operatorTitle: "#14145C",
                        operatorTitleSelected: "#ffffff",
                        pinPad: "#14145C",
                        pinPad123: "#253F54",
                        pinPadTitle: "#ffffff",
                        extraFunctions: "#14145C",
                        extraFunctionsTitle: "#4BE6A9",
                        statusBarStyle: .light)
    }
}
