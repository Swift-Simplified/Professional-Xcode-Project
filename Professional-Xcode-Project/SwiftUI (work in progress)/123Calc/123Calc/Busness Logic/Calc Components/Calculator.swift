//
//  Calculator.swift
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
//   It's the core of the calculator. The brain. It generates all of our behaviour.
//   Architectural Layer: Business Logic Layer
//
// -------------------------------------------------------------------------------------------


import Foundation

class Calculator: CalculatorAPI {
    
    // MARK: - Properties
    
    private(set) var history: [EquationRepresentable] = []
    private var equationBuilder: EquationBuilding
    private let equationBuilderProvider: (() -> EquationBuilding)
    
    // MARK: - Managers
    
    private let dataStore = DataStoreManager(key: Calculator.keys.dataStore)
    
    // MARK: - Display
    
    var lcdDisplayText: String {
        equationBuilder.lcdDisplayText
    }
    
    // MARK: - Properties For Testing
    
    var lhs: Decimal {
        equationBuilder.lhs
    }
    
    var rhs: Decimal? {
        equationBuilder.rhs
    }
    
    var operation: MathOperation? {
        equationBuilder.operation
    }
    
    // MARK: - Initialiser
    
    init(_ equationBuilder: @escaping (() -> EquationBuilding)) {
        self.equationBuilderProvider = equationBuilder
        self.equationBuilder = equationBuilder()
    }
    
    // MARK: - Interaction API
    
    func clearHistory() {
        history = []
    }
    
    func clearPressed() {
        equationBuilder = equationBuilderProvider()
        deleteSavedSession()
    }
    
    func negatePressed() {
        populatePreviousResultIfNeeded(true)
        equationBuilder.negate()
    }
    
    func percentagePressed() {
        populatePreviousResultIfNeeded(true)
        equationBuilder.applyPercentage()
    }
    
    func decimalPressed() {
        if equationBuilder.isCompleted {
            equationBuilder = equationBuilderProvider()
        }
        equationBuilder.applyDecimalPoint()
    }
    
    var result: Decimal? {
        equationBuilder.result
    }
    
    // MARK: - Operations
    
    func addPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.add()
    }
    
    func minusPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.subtract()
    }
    
    func multiplyPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.multiply()
    }
    
    func dividePressed() {
        commitAndPopulatePreviousResultIfNeeded()
        equationBuilder.divide()
    }
    
    func equalsPressed() {
        if equationBuilder.isCompleted {
            var newEquationBuilder = equationBuilderProvider()
            newEquationBuilder.lhs = equationBuilder.result ?? Decimal.zero
            newEquationBuilder.operation = equationBuilder.operation
            newEquationBuilder.rhs = equationBuilder.rhs
            equationBuilder = newEquationBuilder
        }
        
        guard equationBuilder.isReadyToExecute else {
            return
        }
        
        executeMathInputController()
    }
    
    // MARK: - Equation Execution
    
    private func executeMathInputController() {
        equationBuilder.execute()
        appendToHistoryLog(equationBuilder)
        #if DEBUG
        printEquationToDebugConsole(equationBuilder)
        #endif
        saveSession()
    }
    
    private func appendToHistoryLog(_ equationBuilder: EquationBuilding) {
        guard equationBuilder.allowRecordingToTheHistoryLog else { return }
        history.append(equationBuilder.equation)
    }
    
    // MARK: - Print To Console
    
    private func printEquationToDebugConsole(_ equationBuilder: EquationBuilding) {
        // → Using the print command only works in debug mode
        print(equationBuilder.generatePrintout)
    }
    
    // MARK: - Number Input
    
    func numberPressed(_ number: Int) {
        // → Only accept values from the numeric keypad 0..9
        guard number <= 9,
        number >= 0 else { return }
        
        if equationBuilder.isCompleted {
            equationBuilder = equationBuilderProvider()
        }
        equationBuilder.enterNumber(number)
    }
    
    // MARK: - Business Logic & Behaviour
    
    private func commitCurrentEquationIfNeeded() -> Bool {
        if equationBuilder.isCompleted == false,
           equationBuilder.isReadyToExecute {
            executeMathInputController()
            return true
        }
        
        return false
    }
    
    private func populateMathInputControllerWithPreviousResult(_ continueEditingResult: Bool = false) {
        var newEquationBuilder = equationBuilderProvider()
        newEquationBuilder.lhs = equationBuilder.result ?? Decimal(0)
        
        if continueEditingResult == false {
            newEquationBuilder.startEditingRightHandSide()
        }
        equationBuilder = newEquationBuilder
    }
    
    private func commitAndPopulatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        
        // → Scenario 1: user enters 5 * 5 *
        if commitCurrentEquationIfNeeded() {
            populateMathInputControllerWithPreviousResult(continueEditingResult)
        }
        
        // → secanrio 2: user enters 5 * 5 = *
        if equationBuilder.isCompleted {
            populateMathInputControllerWithPreviousResult()
        }
    }
    
    private func populatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        if equationBuilder.isCompleted {
            populateMathInputControllerWithPreviousResult(continueEditingResult)
        }
    }
    
    // MARK: - Restoring Session
    
    func restoreFromLastSession() -> Bool {
        guard
            let lastExecutedEquation = readSavedEquationFromDisk(),
            let lastExecutedResult = lastExecutedEquation.result
            else {
            return false
        }
        
        var newEquationBuilder = equationBuilderProvider()
        newEquationBuilder.lhs = Decimal(1)
        newEquationBuilder.multiply()
        newEquationBuilder.rhs = lastExecutedResult
        newEquationBuilder.execute()
        equationBuilder = newEquationBuilder
        return true
    }
    
    private func saveSession() {
        guard equationBuilder.allowRecordingToTheHistoryLog else { return }
        
        guard
            isMathInputSafeToBeSaved(equationBuilder) == true,
            equationBuilder.result?.isEqual(to: .zero) == false
        else {
            return
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(equationBuilder.equation) {
            dataStore.set(encoded)
        }
    }
    
    private func deleteSavedSession() {
        dataStore.deleteValue()
    }
    
    private func isMathInputSafeToBeSaved(_ equationBuilder: EquationBuilding) -> Bool {
        guard equationBuilder.containsNans == false,  // → crashes when encoding nans
              let _ = equationBuilder.result,
              equationBuilder.isCompleted
        else {
            return false
        }
        return true
    }
    
    private func readSavedEquationFromDisk() -> Equation? {
        guard let savedEquation = dataStore.getValue() as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(Equation.self, from: savedEquation)
    }
    
    // MARK: - Copy & Paste
    
    // → 💡 Tip: Adding system features like copy & paste provides a nicer experience for the user.
    
    func pasteInNumber(from decimal: Decimal) {
        if equationBuilder.isCompleted {
            equationBuilder = equationBuilderProvider()
        }
        
        equationBuilder.pasteIn(decimal)
    }
    
    func pasteInNumber(from mathEquation: EquationRepresentable) {
        guard let result = mathEquation.result else {
            return
        }
        
        equationBuilder = equationBuilderProvider()
        pasteInNumber(from: result)
    }
}
