//
//  PercentageButtonTests.swift
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

class PercentageButtonTests: XCTestCase {
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

    // MARK: - Basic Math

    /// Test pressing the percentage button on the left hand side operand.
    func testPercentageButton_leftHandSideOfEquation() throws {
        // 1 % = 0.01
        sut.numberPressed(1); sut.percentagePressed()
        XCTAssertEqual(sut.lhs, Decimal(0.01))

        // 10 % = 0.1
        sut.clearPressed(); sut.numberPressed(1); sut.numberPressed(0); sut.percentagePressed()
        XCTAssertEqual(sut.lhs, Decimal(0.1))

        // 100 % = 1
        sut.clearPressed(); sut.numberPressed(1); sut.numberPressed(0); sut.numberPressed(0); sut.percentagePressed()
        XCTAssertEqual(sut.lhs, Decimal(1))
    }

    /// Test pressing the percentage button on the right hand side operand.
    func testPercentageButton_rightHandSideOfEquation() throws {
        // 0 + 1 % = 0.01
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(1); sut.percentagePressed()
        XCTAssertEqual(sut.rhs, Decimal(0.01))

        // 0 + 10 % = 0.1
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(1); sut.numberPressed(0); sut.percentagePressed()
        XCTAssertEqual(sut.rhs, Decimal(0.1))

        // 0 + 100 % = 1
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(1); sut.numberPressed(0); sut.numberPressed(0); sut.percentagePressed()
        XCTAssertEqual(sut.rhs, Decimal(1))
    }

    // MARK: - Button Repeatedly Pressed

    /// Test repeatedly pressing the percentage button on the left hand side operand.
    func testPercentageButtonRepeatedlyPressed_leftHandSideOfEquation() throws {
        // 1 % % = 0.0001
        sut.numberPressed(1)
        sut.percentagePressed()
        sut.percentagePressed()
        XCTAssertEqual(sut.lhs, Decimal(0.0001))

        // 4 % % % = 0.000004
        sut.clearPressed(); sut.numberPressed(4)
        sut.percentagePressed()
        sut.percentagePressed()
        sut.percentagePressed()
        XCTAssertEqual(sut.lhs, Decimal(0.000004))
    }

    /// Test repeatedly pressing the percentage button on the right hand side operand.
    func testPercentageButtonRepeatedlyPressed_rightHandSideOfEquation() throws {
        // 0 + 1 % % = 0.0001
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(1)
        sut.percentagePressed()
        sut.percentagePressed()
        XCTAssertEqual(sut.rhs, Decimal(0.0001))

        // 0 + 4 % % % = 0.000004
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(4)
        sut.percentagePressed()
        sut.percentagePressed()
        sut.percentagePressed()
        XCTAssertEqual(sut.rhs, Decimal(0.000004))
    }

    // MARK: - Result

    /// Test pressing the percentage button on the result of an equation.
    func testApplyingPercentageToResult() throws {
        // 300 + 300 = 600
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        // % = 6
        sut.percentagePressed()

        XCTAssertEqual(sut.lhs, Decimal(6))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }

    /// Test pressing the percentage button twice on the result of an equation.
    func testApplyingPercentageToResultTwice() throws {
        // 300 + 300 = 600
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        // % % = 0.06
        sut.percentagePressed()
        sut.percentagePressed()

        XCTAssertEqual(sut.lhs, Decimal(0.06))
        XCTAssertEqual(sut.rhs, nil)
        XCTAssertEqual(sut.result, nil)
    }
}
