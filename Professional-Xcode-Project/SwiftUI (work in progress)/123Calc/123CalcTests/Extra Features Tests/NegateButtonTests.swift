//
//  NegateButtonTests.swift
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
//   It's our testing team! They are testing pressing the negate button.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------

@testable import Calc123
import XCTest

class NegateButtonTests: XCTestCase {
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

    func testLHS_1() throws {
        sut.numberPressed(1)

        sut.negatePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(-1)))
    }

    func testLHS_123() throws {
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.negatePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(-123)))
    }

    func testLHS_123456789() throws {
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

        XCTAssertTrue(sut.lhs == Decimal(-123_456_789))
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(-123_456_789)))
    }

    // MARK: - Continuously Pressing Negate

    func testLHS_NegatePressedTwice() throws {
        sut.numberPressed(1)

        sut.negatePressed()
        sut.negatePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(1)))
    }

    func testLHS_NegatePressedThrice() throws {
        sut.numberPressed(1)

        sut.negatePressed()
        sut.negatePressed()
        sut.negatePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(-1)))
    }

    // MARK: - operands - Right

    func testRHS_1() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)

        sut.negatePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(-1)) ?? false)
    }

    func testRHS_123() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        sut.negatePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(-123)) ?? false)
    }

    func testRHS_123456789() throws {
        sut.numberPressed(1)
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

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(-123_456_789)) ?? false)
    }

    // MARK: - Pressing Button Multiple Times - Right

    func testRHS_NegatePressedTwice() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)

        sut.negatePressed()
        sut.negatePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(1)) ?? false)
    }

    func testRHS_NegatePressedThrice() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)

        sut.negatePressed()
        sut.negatePressed()
        sut.negatePressed()

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(-1)) ?? false)
    }

    // MARK: - Result

    func testNegatingAResult() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.equalsPressed()

        sut.negatePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: -2))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    func testNegatingAResultTwice() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.equalsPressed()

        sut.negatePressed()
        sut.negatePressed()

        XCTAssertTrue(sut.lhs.isEqual(to: 2))
        XCTAssertTrue(sut.rhs == nil)
        XCTAssertTrue(sut.result == nil)
    }

    // MARK: - Negate Decimals - Left

    func testLHS_decimals() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
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
        print("Search for \"MattLog\" in the console")
        print("Unformatted: \(sut.lhs)")
        print("Formatted:   \(sut.lhs.formatted())")

        print("Unformatted: \(Decimal(-0.123456789))")
        print("Formatted:   \(Decimal(-0.123456789).formatted())")
        XCTAssertTrue(sut.lhs.formatted() == Decimal(-0.123456789).formatted())
        // 💡 Tip: Why use .formatted() on this test?
        // 👉🏻 Comparing Decimal numbers causes our tests to fail. They are not accurate enough to compare when they're this long. So we compare their String representation instead.
    }

    // MARK: - Negate Decimals - Right

    func testRHS_decimals() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.decimalPressed()
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

        XCTAssertTrue(sut.rhs?.formatted() == Decimal(-0.123456789).formatted())
    }
}
