//
//  ZeroTests.swift
//  Calc123Tests
//
//  Created by Matthew Harding (Swift engineer & online instructor) on 27/01/2023
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
//   It's our testing team! They are testing what happens when the user presses 0 on the pin pad.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------

@testable import Calc123
import XCTest

class ZeroTests: XCTestCase {
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

    // MARK: - Operands - Left

    func test0_LeftHandEntry() throws {
        sut.numberPressed(0)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    func test00_LeftHandEntry() throws {
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    func test000_LeftHandEntry() throws {
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    // MARK: - Operands - Right

    func test0_RightHandEntry() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    func test00_RightHandEntry() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    func test000_RightHandEntry() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    func test000Addition() throws {
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    func test000Subtraction() throws {
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.minusPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }

    func test000Divide() throws {
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.dividePressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal.nan) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "Error")
    }

    func test000Multiply() throws {
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.multiplyPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }
}
