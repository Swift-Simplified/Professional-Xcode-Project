//
//  SubtractionTests.swift
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


class SubtractionTests: XCTestCase {

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
    
    /// Test the basic subtraction subtracting 1 from each number on the numeric keypad of the calculator.
    func testBasicSubtraction() throws {
        // 0 - 1 = -1
        sut.numberPressed(0); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(-1))
        
        // 1 - 1 = 0
        sut.numberPressed(1); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(0))
        
        // 2 - 1 = 1
        sut.numberPressed(2); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(1))
        
        // 3 - 1 = 2
        sut.numberPressed(3); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(2))
        
        // 4 - 1 = 3
        sut.numberPressed(4); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(3))
        
        // 5 - 1 = 4
        sut.numberPressed(5); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(4))
        
        // 6 - 1 = 5
        sut.numberPressed(6); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(5))
        
        // 7 - 1 = 6
        sut.numberPressed(7); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(6))
        
        // 8 - 1 = 7
        sut.numberPressed(8); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(7))
        
        // 9 - 1 = 8
        sut.numberPressed(9); sut.minusPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(8))
    }
    
    // MARK: - Subtract From Previous Result

    /// Test continuously subtracting 2 from the executed equation.
    func testSubtractingFromPreviousEquation() throws {
        // 1 - 2 = -2
        sut.numberPressed(1)
        sut.minusPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // - 2 = -3
        sut.minusPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // - 2 = -5
        sut.minusPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // - 2 = -7
        sut.minusPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // - 2 = -9
        sut.minusPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(-7))
        XCTAssertEqual(sut.rhs, Decimal(2))
        XCTAssertEqual(sut.result, Decimal(-9))
    }

    // MARK: - Random Equation
    
    /// Test a random and more complicated equation using subtraction
    func testRandomEquation() throws {
        // 7 - 127 = -120
        sut.numberPressed(7)
        sut.minusPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(7)
        sut.equalsPressed()
        
        // - 34 = -154
        sut.minusPressed()
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.equalsPressed()
        
        // - 6 = -160
        sut.minusPressed()
        sut.numberPressed(6)
        sut.equalsPressed()
        
        // - 5 = -165
        sut.minusPressed()
        sut.numberPressed(5)
        sut.equalsPressed()
        
        // - 4 = -169
        sut.minusPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        // - 3 = -172
        sut.minusPressed()
        sut.numberPressed(3)
        sut.equalsPressed()
        
        // - 2 = -174
        sut.minusPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(-172))
        XCTAssertEqual(sut.rhs, Decimal(2))
        XCTAssertEqual(sut.result, Decimal(-174))
    }
}
