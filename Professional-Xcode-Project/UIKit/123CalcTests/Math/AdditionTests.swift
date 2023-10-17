//
//  AdditionTests.swift
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

class AdditionTests: XCTestCase {

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
    
    /// Test the basic addition adding 1 to each number on the numeric keypad of the calculator.
    func testBasicAddition() throws {
        // 0 + 1 = 1
        sut.numberPressed(0); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(1))
        
        // 1 + 1 = 2
        sut.numberPressed(1); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(2))
        
        // 2 + 1 = 3
        sut.numberPressed(2); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(3))
        
        // 3 + 1 = 4
        sut.numberPressed(3); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(4))
        
        // 4 + 1 = 5
        sut.numberPressed(4); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(5))
        
        // 5 + 1 = 6
        sut.numberPressed(5); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(6))
        
        // 6 + 1 = 7
        sut.numberPressed(6); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(7))
        
        // 7 + 1 = 8
        sut.numberPressed(7); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(8))
        
        // 8 + 1 = 9
        sut.numberPressed(8); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(9))
        
        // 9 + 1 = 10
        sut.numberPressed(9); sut.addPressed(); sut.numberPressed(1); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(10))
    }
    
    // MARK: - Addition To Previous Result
    
    /// Test continuously adding 2 to the executed equation.
    func testAddingToPreviousEquation() throws {
        // 1 + 2 = 3
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // + 2 = 5
        sut.addPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // + 2 = 7
        sut.addPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // + 2 = 9
        sut.addPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        // + 2 = 11
        sut.addPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(9))
        XCTAssertEqual(sut.rhs, Decimal(2))
        XCTAssertEqual(sut.result, Decimal(11))
    }
    
    // MARK: - Random Equation
    
    /// Test a random and more complicated equation using addition 
    func testRandomEquation() throws {
        // 7 + 127 = 134
        sut.numberPressed(7)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(7)
        sut.equalsPressed()
        
        // + 34 = 168
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.equalsPressed()

        // + 6 = 174
        sut.addPressed()
        sut.numberPressed(6)
        sut.equalsPressed()
        
        // + 5 = 179
        sut.addPressed()
        sut.numberPressed(5)
        sut.equalsPressed()
        
        // + 4 = 183
        sut.addPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        // + 3 = 186
        sut.addPressed()
        sut.numberPressed(3)
        sut.equalsPressed()
        
        // + 2 = 188
        sut.addPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(186))
        XCTAssertEqual(sut.rhs, Decimal(2))
        XCTAssertEqual(sut.result, Decimal(188))
    }
}
