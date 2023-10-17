//
//  CalculatorAPI.swift
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
//   This provides easy-to-read documentation for all exposed functionality and helps create an interface for the calculator.
//   Architectural Layer: The business logic layer (the main non-visual system).
//
// -------------------------------------------------------------------------------------------

import Foundation

/// The CalculatorAPI has been written to mimick a physical calculator.
/// The interaction of the calculator takes place as if the user was pressing
/// physical buttons on numeric keypad with values ranging between 0 - 9.
/// This structure allows the calculator to be easily connected to a visual
/// presentation layer (UI - user interface) on any platform (macOS, iOS, watchOS).
protocol CalculatorAPI {
    // MARK: - Misc Calculator Buttons.

    /// This function clears any current equation and resets all values back to 0.
    func clearPressed()
    /// This function negates the current value, left, right or result or the equation.
    func negatePressed()
    /// This function divides the current value by 100.
    func percentagePressed()

    // MARK: - Numeric Keypad Buttons

    /// This function should be connected to the numeric keypad and accepts values between 0 - 9.
    func numberPressed(_ number: Int)
    /// This function inputs a decimal point.
    func decimalPressed()

    // MARK: - Math Operator Buttons

    /// This function sets the operator to addition and moves the equation to edit the right hand side operand.
    /// If pressed on an executed equation it will start a new equation moving the result to the left hand operand,
    /// set the operator to addition and begin editting the right hand side operand.
    func addPressed()
    /// This function sets the operator to subtraction and moves the equation to edit the right hand side operand.
    /// If pressed on an executed equation it will start a new equation moving the result to the left hand operand,
    /// set the operator to subtraction and begin editting the right hand side operand.
    func minusPressed()
    /// This function sets the operator to multiplication and moves the equation to edit the right hand side operand.
    /// If pressed on an executed equation it will start a new equation moving the result to the left hand operand,
    /// set the operator to multiplication and begin editting the right hand side operand.
    func multiplyPressed()
    /// This function sets the operator to division and moves the equation to edit the right hand side operand.
    /// If pressed on an executed equation it will start a new equation moving the result to the left hand operand,
    /// set the operator to division and begin editting the right hand side operand.
    func dividePressed()

    // MARK: - Math Execution Button

    /// This function executes the equation. If pressed on an executed equation it will apply the last action again
    /// to the result. i.e. For the equation 1 + 1 = 2 pressing equals again will add another 2 to the result.
    func equalsPressed()

    // MARK: - Inspect Values From The Equation

    /// This property will provide the value of the left hand side operand of the equation. This value is 0 by default.
    var lhs: Decimal { get }
    /// This property will provide the value of the right hand side operand of the equation or nil if nothing has been
    /// entered.
    var rhs: Decimal? { get }
    /// This property will provide the result of the equation or nil if the equation has not been executed.
    var result: Decimal? { get }
    /// This property will provide the operation of the equation or nil if not yet set.
    var operation: MathOperation? { get }

    // MARK: - The Display Of The Calculator

    /// This property will provide the text to display to the user reflecting the current state of the calculator and
    /// equation. This calculator is written as a complete solution. By connecting the buttons and reading the text in
    /// this label (after each button press) the lcd display text will automatically be updated.
    var lcdDisplayText: String { get }

    // MARK: - Copy & Paste

    // TODO: write the documentation for these functions
    func pasteInNumber(from decimal: Decimal)
    func pasteInNumber(from mathEquation: EquationRepresentable)

    // MARK: - Previous Session

    func restoreFromLastSession() -> Bool

    // MARK: - History

    var history: [EquationRepresentable] { get }
}
