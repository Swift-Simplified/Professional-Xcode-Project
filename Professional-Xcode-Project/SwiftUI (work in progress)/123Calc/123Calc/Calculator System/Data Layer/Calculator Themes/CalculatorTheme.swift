//
//  Calc123ulatorTheme.swift
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
//   It's data, to store color hex values in order to change the colors of the app.
//   Architectural Layer: Data Layer
//
// -------------------------------------------------------------------------------------------


import Foundation

enum StatusBarStyle: String, Codable {
    case light = "light"   
    case dark = "dark"
}

struct CalculatorTheme: Codable {
    var id: String
    var background: String
    var display: String
    
    var operatorNormal: String
    var operatorSelected: String
    
    var operatorTitle: String
    var operatorTitleSelected: String
    
    var pinPad: String
    var pinPad123: String
    var pinPadTitle: String
    
    var extraFunctions: String
    var extraFunctionsTitle: String
    
    var statusBarStyle: StatusBarStyle
}
