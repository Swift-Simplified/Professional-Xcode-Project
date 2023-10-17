//
//  DivideTests.swift
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

class DivisionTests: XCTestCase {
    
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
    
    /// Test the basic division dividing each number on the numeric keypad by 2.
    func testBasicDivision() throws {
        // 0 / 2 = 0
        sut.numberPressed(0); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(0))
        
        // 1 / 2 = 0.5
        sut.numberPressed(1); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(0.5))
        
        // 2 / 2 = 1
        sut.numberPressed(2); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(1))
        
        // 3 / 2 = 1.5
        sut.numberPressed(3); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(1.5))
        
        // 4 / 2 = 2
        sut.numberPressed(4); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(2))
        
        // 5 / 2 = 2.5
        sut.numberPressed(5); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(2.5))
        
        // 6 / 2 = 3
        sut.numberPressed(6); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(3))
        
        // 7 / 2 = 3.5
        sut.numberPressed(7); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(3.5))
        
        // 8 / 2 = 4
        sut.numberPressed(8); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(4))
        
        // 9 / 2 = 4.5
        sut.numberPressed(9); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(4.5))
    }

    // MARK: - Divide Previous Result
    
    /// Test continuously dividing the executed equation by 2.
    func testDividingPreviousEquation() throws {
        // 1 / 2 = 0.5
        sut.numberPressed(1)
        sut.dividePressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // / 2 = 0.25
        sut.dividePressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // / 2 = 0.125
        sut.dividePressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // / 2 = 0.0625
        sut.dividePressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // / 2 = 0.03125
        sut.dividePressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(0.0625))
        XCTAssertEqual(sut.rhs, Decimal(2))
        XCTAssertEqual(sut.result, Decimal(0.03125))
    }
    
    // MARK: - Random Equation
    
    /// Test a random and more complicated equation using division
    func testRandomEquation() throws {
        // 8 / 100 = 0.08
        sut.numberPressed(8)
        sut.dividePressed()
        sut.numberPressed(1)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()
        
        // / 4 = 0.02
        sut.dividePressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        // / 2 = 0.001
        sut.dividePressed()
        sut.numberPressed(2)
        sut.equalsPressed()

        // / 1 = 0.001
        sut.dividePressed()
        sut.numberPressed(1)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(0.01))
        XCTAssertEqual(sut.rhs, Decimal(1 ))
        XCTAssertEqual(sut.result, Decimal(0.01))
    }
    
    // MARK: - Dividing By Zero
    
    /// In mathematics dividing by zero is not a valid operation and results in a nan (not a number).
    func testDivisionByZero() throws {
        // 9 / 0 = not a number (nan). Cannot divide by zero in mathematics
        sut.numberPressed(9)
        sut.dividePressed()
        sut.numberPressed(0)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.result, Decimal.nan)
        XCTAssertEqual(sut.lcdDisplayText, "Error")
    }
}
