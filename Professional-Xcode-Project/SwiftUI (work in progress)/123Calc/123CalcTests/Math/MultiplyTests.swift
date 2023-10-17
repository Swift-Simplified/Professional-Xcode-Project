//
//  MultiplyTests.swift
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

class MultiplyTests: XCTestCase {
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

    /// Test the basic multiplication multiplying each number on the numeric keypad by 2.
    func testBasicMultiplication() throws {
        // 0 * 2 = 0
        sut.numberPressed(0); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(0))

        // 1 * 2 = 2
        sut.numberPressed(1); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(2))

        // 2 * 2 = 4
        sut.numberPressed(2); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(4))

        // 3 * 2 = 6
        sut.numberPressed(3); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(6))

        // 4 * 2 = 8
        sut.numberPressed(4); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(8))

        // 5 * 2 = 10
        sut.numberPressed(5); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(10))

        // 6 * 2 = 12
        sut.numberPressed(6); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(12))

        // 7 * 2 = 14
        sut.numberPressed(7); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(14))

        // 8 * 2 = 16
        sut.numberPressed(8); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(16))

        // 9 * 2 = 18
        sut.numberPressed(9); sut.multiplyPressed(); sut.numberPressed(2); sut.equalsPressed()
        XCTAssertEqual(sut.result, Decimal(18))
    }

    // MARK: - Divide Previous Result

    /// Test continuously dividing the executed equation by 2.
    func testDividingPreviousEquation() throws {
        // 1 * 2 = 2
        sut.numberPressed(1)
        sut.multiplyPressed()
        sut.numberPressed(2)
        sut.equalsPressed()

        // * 2 = 4
        sut.multiplyPressed()
        sut.numberPressed(2)
        sut.equalsPressed()

        // * 2 = 8
        sut.multiplyPressed()
        sut.numberPressed(2)
        sut.equalsPressed()

        // * 2 = 16
        sut.multiplyPressed()
        sut.numberPressed(2)
        sut.equalsPressed()

        // * 2 = 32
        sut.multiplyPressed()
        sut.numberPressed(2)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(16))
        XCTAssertEqual(sut.rhs, Decimal(2))
        XCTAssertEqual(sut.result, Decimal(32))
    }

    // MARK: - Random Equation

    /// Test a random and more complicated equation using multiplication
    func testRandomEquation() throws {
        // 7 * 127 = 889
        sut.numberPressed(7)
        sut.multiplyPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(7)
        sut.equalsPressed()

        // * 34 = 30,226
        sut.multiplyPressed()
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.equalsPressed()

        // * 6 = 181,356
        sut.multiplyPressed()
        sut.numberPressed(6)
        sut.equalsPressed()

        // * 5 = 906,780
        sut.multiplyPressed()
        sut.numberPressed(5)
        sut.equalsPressed()

        // * 4 = 3,627,120
        sut.multiplyPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        // * 3 = 10,881,360
        sut.multiplyPressed()
        sut.numberPressed(3)
        sut.equalsPressed()

        // * 2 = 21,762,720
        sut.multiplyPressed()
        sut.numberPressed(2)
        sut.equalsPressed()

        XCTAssertEqual(sut.lhs, Decimal(10_881_360))
        XCTAssertEqual(sut.rhs, Decimal(2))
        XCTAssertEqual(sut.result, Decimal(21_762_720))
    }
}
