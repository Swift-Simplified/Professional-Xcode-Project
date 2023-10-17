//
//  MathEquation.swift
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
//   It's data that represents one equation. It also performs a little math too.
//   Architectural Layer: Data Layer
//
// -------------------------------------------------------------------------------------------


import Foundation

// MARK: - Operation Enum

enum OperationType: String, Codable {
    case add = "add"
    case subtract = "subtract"
    case divide = "divide"
    case multiply  = "multiply"
}

protocol MathEquationRepresentable: Codable {
    var lhs: Decimal { get set }
    var rhs: Decimal? { get set }
    var result: Decimal? { get }
    var operation: OperationType? { get set }
    var isReadyToBeExecuted: Bool { get }
    var executed: Bool { get }
    mutating func execute()
    mutating func negateLeftHandSide()
    mutating func negateRightHandSide()
    mutating func applyPercentageToLeftHandSide()
    mutating func applyPercentageToRightHandSide()
    
    func generatePrintout() -> String
    
    func generateStringRepresentationOfOperator() -> String
}

struct MathEquation: MathEquationRepresentable {
    
    // MARK: - Variables
    
    var lhs: Decimal = 0
    var rhs: Decimal?
    var operation: OperationType?
    var result: Decimal?
    
    var executed: Bool {
        return result != nil
    }
    
    var isReadyToBeExecuted: Bool { // helpful computed properties to isolate business logic
        (rhs != nil) && (operation != nil) && (executed == false)
    }
    
    // MARK: - Equation Math
    
    mutating func execute() {
        guard
            isReadyToBeExecuted == true,
        let operation,
        let rightHandSide = rhs else {
            return
        }
        
        switch operation {
        case .multiply:
        result = lhs * rightHandSide
        case .subtract:
            result = lhs - rightHandSide
        case .add:
            result = lhs + rightHandSide
        case .divide:
            result = lhs / rightHandSide
        }
    }
    
    mutating func negateLeftHandSide() {
        lhs.negate()
    }
    
    mutating func negateRightHandSide() {
        rhs?.negate()
    }
    
    mutating func applyPercentageToLeftHandSide() {
        lhs = calculatePercentageValue(lhs)
    }
    
    mutating func applyPercentageToRightHandSide() {
        rhs = calculatePercentageValue(rhs)
    }

    private func calculatePercentageValue(_ decimal: Decimal?) -> Decimal {
        guard let decimal = decimal else { return .nan }
        return  decimal / 100
    }
    
    // MARK: - Visual Representations
    
    func generatePrintout() -> String {
        let operatorString = generateStringRepresentationOfOperator()
        return lhs.formatted() + " " + operatorString + " " + (rhs?.formatted() ?? "") + " = " + (result?.formatted() ?? "")
    }
    
    func generateStringRepresentationOfOperator() -> String {
        switch operation {
        case .multiply: return "*"
        case .divide: return "/"
        case .add: return "+"
        case .subtract: return "-"
        case .none:
            return ""
        }
    }
}
