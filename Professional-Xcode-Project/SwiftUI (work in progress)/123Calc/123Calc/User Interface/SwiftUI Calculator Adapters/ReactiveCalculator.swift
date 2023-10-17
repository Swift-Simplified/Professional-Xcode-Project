//
//  ReactiveCalculator.swift
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
//   It's a class created to be an adapter between the Calculator system and the reactive
//   SwiftUI framework in order to automatically trigger our SwiftUI Views to redraw
//   themselves.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import Foundation

class ReactiveCalculator: ObservableObject, CalculatorAPI {
    private let calculatorEngine: CalculatorAPI = Calculator {
        EquationBuilder(equation: Equation())
    }

    // MARK: - CalculatorAPI

    var result: Decimal? {
        calculatorEngine.result
    }

    var lcdDisplayText: String {
        calculatorEngine.lcdDisplayText
    }

    func clearPressed() {
        objectWillChange.send()
        calculatorEngine.clearPressed()
    }

    func negatePressed() {
        objectWillChange.send()
        calculatorEngine.negatePressed()
    }

    func percentagePressed() {
        objectWillChange.send()
        calculatorEngine.percentagePressed()
    }

    func numberPressed(_ number: Int) {
        objectWillChange.send()
        calculatorEngine.numberPressed(number)
    }

    func decimalPressed() {
        objectWillChange.send()
        calculatorEngine.decimalPressed()
    }

    func addPressed() {
        objectWillChange.send()
        calculatorEngine.addPressed()
    }

    func minusPressed() {
        objectWillChange.send()
        calculatorEngine.minusPressed()
    }

    func multiplyPressed() {
        objectWillChange.send()
        calculatorEngine.multiplyPressed()
    }

    func dividePressed() {
        objectWillChange.send()
        calculatorEngine.dividePressed()
    }

    func equalsPressed() {
        objectWillChange.send()
        calculatorEngine.equalsPressed()
    }

    func restoreFromLastSession() -> Bool {
        objectWillChange.send()
        return calculatorEngine.restoreFromLastSession()
    }

    var history: [EquationRepresentable] {
        calculatorEngine.history
    }

    func pasteInNumber(from decimal: Decimal) {
        objectWillChange.send()
        calculatorEngine.pasteInNumber(from: decimal)
    }

    func pasteInNumber(from mathEquation: EquationRepresentable) {
        objectWillChange.send()
        calculatorEngine.pasteInNumber(from: mathEquation)
    }

    var rhs: Decimal? {
        calculatorEngine.rhs
    }

    var lhs: Decimal {
        calculatorEngine.lhs
    }

    var operation: MathOperation? {
        calculatorEngine.operation
    }
}
