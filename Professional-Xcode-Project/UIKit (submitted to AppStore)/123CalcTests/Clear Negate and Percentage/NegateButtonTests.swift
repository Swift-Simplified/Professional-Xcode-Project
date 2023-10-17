//
//  NegateButtonTests.swift
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

class NegateButtonTests: XCTestCase {
    
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
    
    /// Test pressing the negate button on the left hand side operand.
    func testNegateButton_leftHandSideOfEquation() throws {
        // 123456789 - = -123456789
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.numberPressed(5)
        sut.numberPressed(6)
        sut.numberPressed(7)
        sut.numberPressed(8)
        sut.numberPressed(9)
        
        sut.negatePressed()

        XCTAssertEqual(sut.lhs, Decimal(-123456789))
    }
    
    /// Test pressing the negate button on the right hand side operand.
    func testNegateButton_rightHandSideOfEquation() throws {
        // 0 + 123456789 - = -123456789
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
        
        sut.negatePressed()

        XCTAssertEqual(sut.rhs, Decimal(-123456789))
    }
    
    // MARK: - Button Repeatedly Pressed
    
    /// Test pressing the negate button repeatedly on the left hand side operand.
    func testNegateButtonRepeatedlyPressed_leftHandSideOfEquation() throws {
        // 1 - - = 1
        sut.numberPressed(1)
        sut.negatePressed()
        sut.negatePressed()
        XCTAssertEqual(sut.lhs, Decimal(1))
        
        // 4 - - - = -4
        sut.clearPressed(); sut.numberPressed(4)
        sut.negatePressed()
        sut.negatePressed()
        sut.negatePressed()
        XCTAssertEqual(sut.lhs, Decimal(-4))
    }
    
    /// Test pressing the negate button repeatedly on the right hand side operand.
    func testNegateButtonRepeatedlyPressed_rightHandSideOfEquation() throws {
        // 0 + 1 - - = 1
        sut.numberPressed(0); sut.addPressed();
        sut.numberPressed(1)
        sut.negatePressed()
        sut.negatePressed()
        XCTAssertEqual(sut.rhs, Decimal(1))
        
        // 0 + 4 - - - = -4
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed();
        sut.numberPressed(4)
        sut.negatePressed()
        sut.negatePressed()
        sut.negatePressed()
        XCTAssertEqual(sut.rhs, Decimal(-4))
    }
    
    // MARK: - Result
    
    /// Test pressing the negate button on the result of an equation.
    func testNegatingAResult() throws {
        // 1 + 1 = 2
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.equalsPressed()
        
        // - = -2
        sut.negatePressed()
        
        XCTAssertEqual(sut.lhs, Decimal(-2))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }
    
    /// Test pressing the negate button twice on the result of an equation.
    func testNegatingAResultTwice() throws {
        // 1 + 1 = 2
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.equalsPressed()
        
        // - - = 2
        sut.negatePressed()
        sut.negatePressed()
        
        XCTAssertEqual(sut.lhs, Decimal(2))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }
}
