//
//  VibrantCalculatorTheme.swift
//  Calc123
//
//  Created by Matthew Harding (Swift engineer & online instructor) on 26/01/2023
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
//   It's a color theme, used to display a different color theme.
//   Architectural Layer: Data Layer
//
//   💡 Convenience Tip 👉🏻 We used extensions to seperate themes into seperate files providing
//   designers with editable documents. Also allowing us to conveniently load the theme array.
// -------------------------------------------------------------------------------------------


import Foundation

extension ThemeLoader {
    
    var bloodOrangeTheme: CalculatorTheme {
        CalculatorTheme(id:"9",
        background:             "#4A1D41",
        display:                "#ffffff",
        operatorNormal:         "#8D3362",
        operatorSelected:       "#AA0E67",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#C64661",
        pinPad123:              "#CC5E79",
        pinPadTitle:            "#ffffff",
        extraFunctions:         "#9C3766",
        extraFunctionsTitle:    "#ffffff",
        statusBarStyle: .light)
    }
}
