//
//  PercentageButtonTests.swift
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
//   It's our testing team! They are testing pressing the percentage button.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------

@testable import Calc123
import XCTest

class PercentageButtonTests: XCTestCase {
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

    // MARK: - operands - Left

    func testLHS_1() throws {
        sut.numberPressed(1)

        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.01)))
        XCTAssertTrue(sut.lcdDisplayText == "0.01")
    }

    func testLHS_100() throws {
        sut.numberPressed(1)
        sut.numberPressed(0)
        sut.numberPressed(0)

        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(1)))
        XCTAssertTrue(sut.lcdDisplayText == "1")
    }

    func testLHS_200() throws {
        sut.numberPressed(2)
        sut.numberPressed(0)
        sut.numberPressed(0)

        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(2)))
        XCTAssertTrue(sut.lcdDisplayText == "2")
    }

    func testLHS_percentagePressedTwice() throws {
        sut.numberPressed(1)

        sut.percentagePressed()
        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0001)))
        XCTAssertTrue(sut.lcdDisplayText == "0.0001")
    }

    func testLHS_percentagePressedThrice() throws {
        sut.numberPressed(1)

        sut.percentagePressed()
        sut.percentagePressed()
        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.000001)))
        XCTAssertTrue(sut.lcdDisplayText == "0.000001")
    }

    // MARK: - operands - Right

    func testRHS_1() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)

        sut.percentagePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.01)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.01")
    }

    func testRHS_100() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(0)
        sut.numberPressed(0)

        sut.percentagePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "1")
    }

    func testRHS_200() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(2)
        sut.numberPressed(0)
        sut.numberPressed(0)

        sut.percentagePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(2)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "2")
    }

    func testRHS_percentagePressedTwice() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)

        sut.percentagePressed()
        sut.percentagePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0001)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.0001")
    }

    func testRHS_percentagePressedThrice() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)

        sut.percentagePressed()
        sut.percentagePressed()
        sut.percentagePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.000001)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.000001")
    }

    // MARK: - Result

    func testResult() throws {
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: 6))
        XCTAssertTrue(sut.lcdDisplayText == "6")
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testResult_percentagePressedTwice() throws {
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        sut.percentagePressed()
        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: 0.06))
        XCTAssertTrue(sut.lcdDisplayText == "0.06")
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testResult_percentagePressedThrice() throws {
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.equalsPressed()

        sut.percentagePressed()
        sut.percentagePressed()
        sut.percentagePressed()

        XCTAssertTrue(sut.lhs.formatted() == Decimal(0.0006).formatted())
        XCTAssertTrue(sut.lcdDisplayText == "0.0006")
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }
}
