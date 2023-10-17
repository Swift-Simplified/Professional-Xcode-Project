//
//  LightBlueCalculatorTheme.swift
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
//   It's a color theme, used to display a different color theme.
//   Architectural Layer: Data Layer
//
//   💡 Convenience Tip 👉🏻 We used extensions to seperate themes into seperate files providing
//   designers with editable documents. Also allowing us to conveniently load the theme array.
// -------------------------------------------------------------------------------------------


import Foundation

extension ThemeLoader {
    
    var lightBlueTheme: CalculatorTheme {
        CalculatorTheme(id:"4",
        background:             "#F8F8F8",
        display:                "#000000",
        operatorNormal:         "#00B4FF",
        operatorSelected:       "#0265FF",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#EEEEEE",
        pinPad123:              "#D9F3F9",
        pinPadTitle:            "#000000",
        extraFunctions:         "#EAF7F9",
        extraFunctionsTitle:    "#00B4FF",
        statusBarStyle: .dark)
    }
}
