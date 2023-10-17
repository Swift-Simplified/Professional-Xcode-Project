//
//  ViewModel.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//

import Foundation


class ReactiveCalculatorAPI: ObservableObject, CalculatorAPI {
//    let calculatorEngine: CalculatorAPI
    private let calculatorEngine: CalculatorAPI = {
        Calc123Engine() {
            MathInputController(equation: MathEquation())
        }
    }()
    
//    init(calculatorEngine: CalculatorAPI) {
//        self.calculatorEngine = calculatorEngine
//    }
    
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
    
    var history: [MathEquationRepresentable] {
        calculatorEngine.history
    }
    
    func pasteInNumber(from decimal: Decimal) {
        calculatorEngine.pasteInNumber(from: decimal)
        objectWillChange.send()
    }
    
    func pasteInNumber(from mathEquation: MathEquationRepresentable) {
        calculatorEngine.pasteInNumber(from: mathEquation)
        objectWillChange.send()
    }
    
    var rhs: Decimal? {
        calculatorEngine.rhs
    }
    var lhs: Decimal {
        calculatorEngine.lhs
    }
}


/**
 
 
 
 var lcdDisplayText: String {
     calculatorEngine.lcdDisplayText
 }
 
 var selectedOperator: OperationType?
 
 func numberPressed(_ number: Int) {
     calculatorEngine.numberPressed(number)
     update()
 }
 
 func operatorPressed(_ operationType: OperationType) {
     switch operationType {
     case .add: calculatorEngine.addPressed()
     case .subtract: calculatorEngine.minusPressed()
     case .divide: calculatorEngine.dividePressed()
     case .multiply: calculatorEngine.multiplyPressed()
     }
     update()
 }
 
 func equalsPressed() {
     calculatorEngine.equalsPressed()
     update()
 }
 
 private func update() {
     objectWillChange.send()
 }
 
 */
