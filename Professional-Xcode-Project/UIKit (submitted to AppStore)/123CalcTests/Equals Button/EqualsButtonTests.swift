//
//  EqualsButtonTests.swift
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

class EqualsButtonTests: XCTestCase {
    
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
    
    /// Test the basic equations ensuring that the equals button provides a result to the equation.
    func testBasicEquation() throws {
        // 1 + 2 = 3
        sut.numberPressed(1); sut.addPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(3))
        
        // 1 - 2 = -1
        sut.numberPressed(1); sut.minusPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(-1))
        
        // 1 / 2 = 0.5
        sut.numberPressed(1); sut.dividePressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(0.5))
        
        // 1 * 2 = 2
        sut.numberPressed(1); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(2))
    }
    
    // MARK: - Continuously Pressing Equals After Executing An Equation
    
    /// Test creating an equation using addition followed by repeatedly pressing the equals button.
    /// Repeatedly pressing the equals button should repeat the last operation again. For example,
    /// if addition was the last action the same number will be added to the result of the equation.
    func testAdditionFollowedByRepeatedlyPressingEqualsButton() throws {
        // 4 + 4 = 8
        sut.numberPressed(4)
        sut.addPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        // + 4 = 12
        sut.equalsPressed()
        
        // + 4 = 16
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(12))
        XCTAssertEqual(sut.rhs, Decimal(4))
        XCTAssertEqual(sut.result, Decimal(16))
    }

    /// Test creating an equation using subtraction followed by repeatedly pressing the equals button.
    /// Repeatedly pressing the equals button should repeat the last operation again. For example,
    /// if subtraction was the last action the same number will be subtracted from the result of the equation.
    func testSubtractionFollowedByRepeatedlyPressingEqualsButton() throws {
        // 4 - 4 = 0
        sut.numberPressed(4)
        sut.minusPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        // - 4 = -4
        sut.equalsPressed()
        
        // - 4 = -8
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(-4))
        XCTAssertEqual(sut.rhs, Decimal(4))
        XCTAssertEqual(sut.result, Decimal(-8))
    }
    
    /// Test creating an equation using division followed by repeatedly pressing the equals button.
    /// Repeatedly pressing the equals button should repeat the last operation again. For example,
    /// if division was the last action the result of the equation will be divided by that number again.
    func testDivisionFollowedByRepeatedlyPressingEqualsButton() throws {
        // 4 / 4 = 1
        sut.numberPressed(4)
        sut.dividePressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        // / 4 = 0.25
        sut.equalsPressed()
        
        // / 4 = 0.0625
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(0.25))
        XCTAssertEqual(sut.rhs, Decimal(4))
        XCTAssertEqual(sut.result, Decimal(0.0625))
    }
    
    /// Test creating an equation using multiplication followed by repeatedly pressing the equals button.
    /// Repeatedly pressing the equals button should repeat the last operation again. For example,
    /// if multiplication was the last action the result of the equation will be multiplied by the same number.
    func testMultiplicationFollowedByRepeatedlyPressingEqualsButton() throws {
        // 4 * 4 = 16
        sut.numberPressed(4)
        sut.multiplyPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        // * 4 = 64
        sut.equalsPressed()
        
        // * 4 = 256
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(64))
        XCTAssertEqual(sut.rhs, Decimal(4))
        XCTAssertEqual(sut.result, Decimal(256))
    }
}

