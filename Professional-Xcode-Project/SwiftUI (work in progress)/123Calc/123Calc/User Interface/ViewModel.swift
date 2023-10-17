//
//  ViewModel.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//

import Foundation


class ReactiveCalculatorAPI: ObservableObject, CalculatorAPI {
    private let calculatorEngine: CalculatorAPI = {
        Calculator() {
            EquationBuilder(equation: Equation())
        }
    }()
    
    // MARK: - CalculatorAPI
    var result: Decimal? {
        calculatorEngine.result
    }
    var lcdDisplayText: String {
        calculatorEngine.lcdDisplayText
    }
    
    func clearPressed() {
        calculatorEngine.clearPressed()
        objectWillChange.send()
    }
    func negatePressed() {
        calculatorEngine.negatePressed()
        objectWillChange.send()
    }
    func percentagePressed() {
        calculatorEngine.percentagePressed()
        objectWillChange.send()
    }
    func numberPressed(_ number: Int) {
        calculatorEngine.numberPressed(number)
        objectWillChange.send()
    }
    func decimalPressed() {
        calculatorEngine.decimalPressed()
        objectWillChange.send()
    }
    func addPressed() {
        calculatorEngine.addPressed()
        objectWillChange.send()
    }
    func minusPressed() {
        calculatorEngine.minusPressed()
        objectWillChange.send()
    }
    func multiplyPressed() {
        calculatorEngine.multiplyPressed()
        objectWillChange.send()
    }
    func dividePressed() {
        calculatorEngine.dividePressed()
        objectWillChange.send()
    }
    func equalsPressed() {
        calculatorEngine.equalsPressed()
        objectWillChange.send()
    }
    
    func restoreFromLastSession() -> Bool {
        calculatorEngine.restoreFromLastSession()
    }
    
    var history: [EquationRepresentable] {
        calculatorEngine.history
    }
    
    func pasteInNumber(from decimal: Decimal) {
        calculatorEngine.pasteInNumber(from: decimal)
        objectWillChange.send()
    }
    
    func pasteInNumber(from mathEquation: EquationRepresentable) {
        calculatorEngine.pasteInNumber(from: mathEquation)
        objectWillChange.send()
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
