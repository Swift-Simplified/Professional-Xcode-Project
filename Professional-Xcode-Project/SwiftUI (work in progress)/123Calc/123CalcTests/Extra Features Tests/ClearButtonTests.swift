//
//  ClearButtonTests.swift
//  Calc123Tests
//
//  Created by Matthew Harding (Swift engineer & online instructor) on 26/01/2023
//
//  Matthew Harding                 → All rights reserved
//  Website                         → https://www.swiftsimplified.com
//
//  We 🧡 Swift
//  Welcome to our community of Swift Simplified students!
//
//  🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
// -------------------------------------------------------------------------------------------
//
// → What's This File?
//   It's our testing team! They are testing pressing the clear button.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------

@testable import Calc123
import XCTest

class ClearButtonTests: XCTestCase {
    // MARK: - System Under Test

    var sut: CalculatorAPI!

    // MARK: - Setup And Tear Down

    override func setUp() {
        sut = Calc123Engine {
            MathInputController(equation: MathEquation())
        }
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Clear

    func testLHS_clear() throws {
        sut.numberPressed(3)

        sut.clearPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testLHS_123Clear() throws {
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testRHS_123Clear() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.clearPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testClearAfterResult() throws {
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.equalsPressed()

        sut.clearPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testMultipleClear() throws {
        sut.numberPressed(3)

        sut.clearPressed()
        sut.clearPressed()
        sut.clearPressed()
        sut.clearPressed()
        sut.clearPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testMultipleClearAfterResult() throws {
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.equalsPressed()

        sut.clearPressed()
        sut.clearPressed()
        sut.clearPressed()
        sut.clearPressed()
        sut.clearPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }
}
