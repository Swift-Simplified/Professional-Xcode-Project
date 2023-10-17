//
//  iOSBFreeCalculatorEngine.swift
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
//   It's the core of the calculator. The brain. It generates all of our behaviour.
//   Architectural Layer: Business Logic Layer
//
// -------------------------------------------------------------------------------------------


import Foundation


class Calc123Engine: CalculatorAPI {
    
    // MARK: - Variables
    
    private(set) var history: [MathEquationRepresentable] = []
    private var mathInputController: CalculatorInput
    private let calculatorInputCreator: (() -> CalculatorInput)
    
    // MARK: - Managers
    
    private let dataStore = DataStoreManager(key: Calc123Engine.keys.dataStore)
    
    // MARK: - Display
    
    var lcdDisplayText: String {
        mathInputController.lcdDisplayText
    }
    
    // MARK: - Properties For Testing
    
    var lhs: Decimal {
        mathInputController.lhs
    }
    
    var rhs: Decimal? {
        mathInputController.rhs
    }
    
    // MARK: - Initialiser
    
    init(_ calculatorInputCreator: @escaping (() -> CalculatorInput)) {
        self.calculatorInputCreator = calculatorInputCreator
        self.mathInputController = calculatorInputCreator()
    }
    
    // MARK: - Interaction API
    
    func clearHistory() {
        history = []
    }
    
    func clearPressed() {
        mathInputController = calculatorInputCreator()
        deleteSavedSession()
    }
    
    func negatePressed() {
        populatePreviousResultIfNeeded(true)
        mathInputController.negate()
    }
    
    func percentagePressed() {
        populatePreviousResultIfNeeded(true)
        mathInputController.applyPercentage()
    }
    
    func decimalPressed() {
        if mathInputController.isCompleted {
            mathInputController = calculatorInputCreator()
        }
        mathInputController.applyDecimalPoint()
    }
    
    var result: Decimal? {
        mathInputController.result
    }
    
    // MARK: - Operations
    
    func addPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        mathInputController.add()
    }
    
    func minusPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        mathInputController.subtract()
    }
    
    func multiplyPressed() {
        commitAndPopulatePreviousResultIfNeeded()
        mathInputController.multiply()
    }
    
    func dividePressed() {
        commitAndPopulatePreviousResultIfNeeded()
        mathInputController.divide()
    }
    
    func equalsPressed() {
        if mathInputController.isCompleted {
            var newMathInput = calculatorInputCreator()
            newMathInput.lhs = mathInputController.result ?? Decimal.zero
            newMathInput.operation = mathInputController.operation
            newMathInput.rhs = mathInputController.rhs
            mathInputController = newMathInput
        }
        
        guard mathInputController.isReadyToExecute else {
            return
        }
        
        executeMathInputController()
    }
    
    // MARK: - Equation Execution
    
    private func executeMathInputController() {
        mathInputController.execute()
        appendToHistoryLog(mathInputController)
        printEquationToDebugConsole(mathInputController)
        saveSession()
    }
    
    private func appendToHistoryLog(_ inputController: CalculatorInput) {
        guard inputController.allowRecordingToTheHistoryLog else { return }
        history.append(inputController.equation)
    }
    
    // MARK: - Print To Console
    
    private func printEquationToDebugConsole(_ mathInputController: CalculatorInput) {
        // → Using the print command only works in debug mode
        print(mathInputController.generatePrintout)
    }
    
    // MARK: - Number Input
    
    func numberPressed(_ number: Int) {
        // → Only accept values from the numeric keypad 0..9
        guard number <= 9,
        number >= 0 else { return }
        
        if mathInputController.isCompleted {
            mathInputController = calculatorInputCreator()
        }
        mathInputController.enterNumber(number)
    }
    
    // MARK: - Business Logic & Behaviour
    
    private func commitCurrentEquationIfNeeded() -> Bool {
        if mathInputController.isCompleted == false,
           mathInputController.isReadyToExecute {
            executeMathInputController()
            return true
        }
        
        return false
    }
    
    private func populateMathInputControllerWithPreviousResult(_ continueEditingResult: Bool = false) {
        var newMathInput = calculatorInputCreator()
        newMathInput.lhs = mathInputController.result ?? Decimal(0)
        
        if continueEditingResult == false {
            newMathInput.startEditingRightHandSide()
        }
        mathInputController = newMathInput
    }
    
    private func commitAndPopulatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        
        // → Scenario 1: user enters 5 * 5 *
        if commitCurrentEquationIfNeeded() {
            populateMathInputControllerWithPreviousResult(continueEditingResult)
        }
        
        // → secanrio 2: user enters 5 * 5 = *
        if mathInputController.isCompleted {
            populateMathInputControllerWithPreviousResult()
        }
    }
    
    private func populatePreviousResultIfNeeded(_ continueEditingResult: Bool = false) {
        if mathInputController.isCompleted {
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
        
        var newMathInput = calculatorInputCreator()
        newMathInput.lhs = Decimal(1)
        newMathInput.multiply()
        newMathInput.rhs = lastExecutedResult
        newMathInput.execute()
        mathInputController = newMathInput
        return true
    }
    
    private func saveSession() {
        guard mathInputController.allowRecordingToTheHistoryLog else { return }
        
        guard
            isMathInputSafeToBeSaved(mathInputController) == true,
            mathInputController.result?.isEqual(to: .zero) == false
        else {
            return
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(mathInputController.equation) {
            dataStore.set(encoded)
        }
    }
    
    private func deleteSavedSession() {
        dataStore.deleteValue()
    }
    
    private func isMathInputSafeToBeSaved(_ mathInput: CalculatorInput) -> Bool {
        guard mathInput.containsNans == false,  // → crashes when encoding nans
              let _ = mathInput.result,
              mathInput.isCompleted
        else {
            return false
        }
        return true
    }
    
    private func readSavedEquationFromDisk() -> MathEquation? {
        guard let savedEquation = dataStore.getValue() as? Data else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(MathEquation.self, from: savedEquation)
    }
    
    // MARK: - Copy & Paste
    
    // → 💡 Tip: Adding system features like copy & paste provides a nicer experience for the user.
    
    func pasteInNumber(from decimal: Decimal) {
        if mathInputController.isCompleted {
            mathInputController = calculatorInputCreator()
        }
        
        mathInputController.pasteIn(decimal)
    }
    
    func pasteInNumber(from mathEquation: MathEquationRepresentable) {
        guard let result = mathEquation.result else {
            return
        }
        
        mathInputController = calculatorInputCreator()
        pasteInNumber(from: result)
    }
}
