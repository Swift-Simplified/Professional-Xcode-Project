//
//  NumericKeypadTests.swift
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

class NumericKeypadTests: XCTestCase {
    
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

    // MARK: - Operands - Left Hand Side Of Equation
    
    /// Test entering numeric values on the left hand side of the equation.
    func testInputOfLeftHandSideOfEquation() throws {
        // 123456789
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.numberPressed(5)
        sut.numberPressed(6)
        sut.numberPressed(7)
        sut.numberPressed(8)
        sut.numberPressed(9)

        XCTAssertEqual(sut.lhs, Decimal(123456789))
    }
    
    // MARK: - Operands - Right Hand Side Of Equation
    
    /// Test entering numeric values on the right hand side of the equation.
    func testInputOfRightHandSideOfEquation() throws {
        // 0 + 123456789
        sut.numberPressed(0)
        sut.addPressed()
        
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.numberPressed(5)
        sut.numberPressed(6)
        sut.numberPressed(7)
        sut.numberPressed(8)
        sut.numberPressed(9)

        XCTAssertEqual(sut.rhs, Decimal(123456789))
    }
    
    // MARK: - keypad Restrictions (Numbers 0 - 9) - Left Hand Side Of Equation
    
    /// Test that the range of numeric input is between 0 and 9, representing a physical numeric keypad
    /// of limited options. 
    func testInputValidation_leftHandSideOfEquation() throws {
        // invalid. 0
        sut.numberPressed(-2)
        XCTAssertEqual(sut.lhs, Decimal(0))
        
        // invalid. 0
        sut.clearPressed(); sut.numberPressed(-1)
        XCTAssertEqual(sut.lhs, Decimal(0))
        
        // valid. 0
        sut.clearPressed(); sut.numberPressed(0)
        XCTAssertEqual(sut.lhs, Decimal(0))
        
        // valid. 1
        sut.clearPressed(); sut.numberPressed(1)
        XCTAssertEqual(sut.lhs, Decimal(1))
        
        // valid. 2
        sut.clearPressed(); sut.numberPressed(2)
        XCTAssertEqual(sut.lhs, Decimal(2))
        
        // valid. 3
        sut.clearPressed(); sut.numberPressed(3)
        XCTAssertEqual(sut.lhs, Decimal(3))
        
        // valid. 4
        sut.clearPressed(); sut.numberPressed(4)
        XCTAssertEqual(sut.lhs, Decimal(4))
        
        // valid. 5
        sut.clearPressed(); sut.numberPressed(5)
        XCTAssertEqual(sut.lhs, Decimal(5))
        
        // valid. 6
        sut.clearPressed(); sut.numberPressed(6)
        XCTAssertEqual(sut.lhs, Decimal(6))
        
        // valid. 7
        sut.clearPressed(); sut.numberPressed(7)
        XCTAssertEqual(sut.lhs, Decimal(7))
        
        // valid. 8
        sut.clearPressed(); sut.numberPressed(8)
        XCTAssertEqual(sut.lhs, Decimal(8))
        
        // valid. 9
        sut.clearPressed(); sut.numberPressed(9)
        XCTAssertEqual(sut.lhs, Decimal(9))
        
        // invalid. 0
        sut.clearPressed(); sut.numberPressed(10)
        XCTAssertEqual(sut.lhs, Decimal(0))
        
        // invalid. 0
        sut.clearPressed(); sut.numberPressed(11)
        XCTAssertEqual(sut.lhs, Decimal(0))
    }
    
    // MARK: - Numeric Keypad Restrictions (Numbers 0 - 9) - Right Hand Side Of Equation
    
    /// Test that the range of numeric input is between 0 and 9, representing a physical numeric keypad
    /// of limited options.
    func testInputValidation_rightHandSideOfEquation() throws {
        // invalid. nil
        sut.numberPressed(0); sut.addPressed(); sut.numberPressed(-2)
        XCTAssertEqual(sut.rhs, nil)
        
        // invalid. nil
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(-1)
        XCTAssertEqual(sut.rhs, nil)
        
        // valid. 0
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(0)
        XCTAssertEqual(sut.rhs, Decimal(0))
        
        // valid. 1
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(1)
        XCTAssertEqual(sut.rhs, Decimal(1))
        
        // valid. 2
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(2)
        XCTAssertEqual(sut.rhs, Decimal(2))
        
        // valid. 3
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(3)
        XCTAssertEqual(sut.rhs, Decimal(3))
        
        // valid. 4
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(4)
        XCTAssertEqual(sut.rhs, Decimal(4))
        
        // valid. 5
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(5)
        XCTAssertEqual(sut.rhs, Decimal(5))
        
        // valid. 6
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(6)
        XCTAssertEqual(sut.rhs, Decimal(6))
        
        // valid. 7
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(7)
        XCTAssertEqual(sut.rhs, Decimal(7))
        
        // valid. 8
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(8)
        XCTAssertEqual(sut.rhs, Decimal(8))
        
        // valid. 9
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(9)
        XCTAssertEqual(sut.rhs, Decimal(9))
        
        // invalid. nil
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(10)
        XCTAssertEqual(sut.rhs, nil)
        
        // invalid. nil
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed(); sut.numberPressed(11)
        XCTAssertEqual(sut.rhs, nil)
    }
}
