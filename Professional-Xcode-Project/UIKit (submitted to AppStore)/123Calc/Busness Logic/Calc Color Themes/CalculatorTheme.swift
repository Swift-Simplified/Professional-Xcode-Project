//
//  CalculatorTheme.swift
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
//   It's data, to store color hex values in order to change the colors of the app.
//   Architectural Layer: The business logic layer (the main non-visual system).
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
