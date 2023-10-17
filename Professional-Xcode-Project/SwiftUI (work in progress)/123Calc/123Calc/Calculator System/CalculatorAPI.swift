//
//  CalculatorAPI.swift
//  Calc123
//
//  Created by Matthew Harding (Swift engineer & online instructor) on 25/01/2023
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
//   This provides easy-to-read documentation for all exposed functionality and helps create an interface for the calculator.
//   Architectural Layer: Interface between "the system" and the presentation layer.
//
// -------------------------------------------------------------------------------------------


import Foundation

protocol CalculatorAPI {
    var result: Decimal? { get }
    var lcdDisplayText: String { get }
    func clearPressed()
    func negatePressed()
    func percentagePressed()
    func numberPressed(_ number: Int)
    func decimalPressed()
    func addPressed()
    func minusPressed()
    func multiplyPressed()
    func dividePressed()
    func equalsPressed()
    
    func restoreFromLastSession() -> Bool
    var history: [MathEquationRepresentable] { get }
    
    func pasteInNumber(from decimal: Decimal)
    func pasteInNumber(from mathEquation: MathEquationRepresentable)
    
    var rhs: Decimal? { get }
    var lhs: Decimal { get }
}
