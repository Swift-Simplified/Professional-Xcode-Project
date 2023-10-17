//
//  ClearButtonTests.swift
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

@testable import Calc123
import XCTest

class ClearButtonTests: XCTestCase {
    // MARK: - System Under Test

    var sut: CalculatorAPI!

    // MARK: - Setup And Tear Down

    override func setUp() {
        sut = Calculator {
            // The calculator doesn't create the EquationBuilder or Equation values internally. This is known as "inversion of control" and is a bit advanced but allows us to provide different implementations of Equation and the EquationBuilder if we wanted to.
            EquationBuilder(equation: Equation())
        }
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Basic Clear

    /// Test pressing the clear button before entering an equation.
    func testClearingFromLaunch() throws {
        // clear = 0
        sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }

    /// Test pressing the clear button after entering a left hand side operand.
    func testClearingLeftHandSideOfEquation() throws {
        // 123 clear = 0
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }

    /// Test pressing the clear button after entering a right hand side operand.
    func testClearingRightHandSideOfEquation() throws {
        // 1 + 123 clear = 0
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }

    /// Test pressing the clear button after executing an equation.
    func testClearingAfterResult() throws {
        // 123 + 123 = 246
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.equalsPressed()

        // clear = 0
        sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)

        // clear clear = 0
        sut.clearPressed(); sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }

    // MARK: - Button Repeatedly Pressed

    /// Test pressing the clear button repeatedly after entering a left hand side operand.
    func testClearButtonRepeatedlyPressed_leftHandSideOfEquation() throws {
        // 123 clear clear = 0
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed(); sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)

        // 123 clear clear clear  = 0
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed(); sut.clearPressed(); sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }

    /// Test pressing the clear button repeatedly after entering a right hand side operand.
    func testClearButtonRepeatedlyPressed_rightHandSideOfEquation() throws {
        // 1 + 123 clear clear = 0
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed(); sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)

        // 1 + 123 clear clear clear = 0
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed(); sut.clearPressed(); sut.clearPressed()

        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }
}
