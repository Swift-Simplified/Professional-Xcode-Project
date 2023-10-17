//
//  DecimalTests.swift
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
//   This file contains the unit tests, which execute on the components created within the
//   business logic layer of the app. We do not unit test the user interface (UI).
//   Write unit tests to ensure the actual output matches the expected output for all
//   possible known scenarios.
//   Architectural Layer: Unit tests.
//
// -------------------------------------------------------------------------------------------


import XCTest
@testable import Calc123

class DecimalMathTests: XCTestCase {
    
    // MARK: - System Under Test
    
    var sut: CalculatorAPI!
    
    // MARK: - Setup And Tear Down
    override func setUp() {
        sut = Calculator() {
            // The calculator doesn't create the EquationBuilder or Equation values internally. This is known as "inversion of control" and is a bit advanced but allows us to provide different implementations of Equation and the EquationBuilder if we wanted to. 
            EquationBuilder(equation: Equation())
        }
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Basic Math
    
    /// Test basic addition using decimals.
    func testDecimalAddition() throws {
        // 0.6 + 0.4 = 1
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(6)
        
        sut.addPressed()
        
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(0.6))
        XCTAssertEqual(sut.rhs, Decimal(0.4))
        XCTAssertEqual(sut.result, Decimal(1))
        XCTAssertEqual(sut.lcdDisplayText, "1")
    }
    
    /// Test basic subtraction using decimals.
    func testDecimalSubtraction() throws {
        // 0.9 - 0.7 = 0.2
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(9)
        
        sut.minusPressed()
        
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(7)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(0.9))
        XCTAssertEqual(sut.rhs, Decimal(0.7))
        XCTAssertEqual(sut.result, Decimal(0.2))
        XCTAssertEqual(sut.lcdDisplayText, "0.2")
    }
}
