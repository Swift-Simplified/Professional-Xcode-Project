//
//  OrangeCalculatorTheme.swift
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
    
    var orangeTheme: CalculatorTheme {
        CalculatorTheme(id:"10",
        background:             "#DC6969",
        display:                "#ffffff",
        operatorNormal:         "#CC4D4D",
        operatorSelected:       "#AB2F2F",
        operatorTitle:          "#ffffff",
        operatorTitleSelected:  "#ffffff",
        pinPad:                 "#C94848",
        pinPad123:              "#AB2F2F",
        pinPadTitle:            "#ffffff",
        extraFunctions:         "#D05353",
        extraFunctionsTitle:    "#ffffff",
        statusBarStyle: .light)
    }
}
