//
//  DecimalTests.swift
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
//   It's our testing team! They are testing what happens when the user presses . on the pin pad.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------

@testable import Calc123
import XCTest

class DecimalTests: XCTestCase {
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

    // MARK: - Decimal Zeros - LHS

    func testImmediateDecimalPress() throws {
        sut.decimalPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0.")
    }

    func testDecimalPress() throws {
        sut.numberPressed(0)
        sut.decimalPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0.")
    }

    func testLHS_0_0() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0.0")
    }

    func testLHS_0_00() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0.00")
    }

    func testLHS_0_000() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0.000")
    }

    func testLHS_0_0005() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(5)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0005)))
        XCTAssertTrue(sut.lcdDisplayText == "0.0005")
    }

    // MARK: - Decimal Numbers

    func testLHS_0_1() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(1)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.1)))
        XCTAssertTrue(sut.lcdDisplayText == "0.1")
    }

    func testLHS_0_1234() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.1234)))
        XCTAssertTrue(sut.lcdDisplayText == "0.1234")
    }

    func testLHS_0_123456789() throws {
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

        XCTAssertTrue(sut.lhs.formatted() == Decimal(0.123456789).formatted())
        XCTAssertTrue(sut.lcdDisplayText == "0.123457")
    }

    // MARK: - Decimal Zeros - RHS

    func testRHS_ImmediateDecimalPress() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.decimalPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0.")
    }

    func testRHS_DecimalPress() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.decimalPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(sut.lcdDisplayText == "0.")
    }

    func testRHS_0_0() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.0)) ?? false)
    }

    func testRHS_0_1() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(1)

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.1)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.1")
    }

    func testRHS_0_1234() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.1234)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.1234")
    }

    func testRHS_0_123456789() throws {
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

        XCTAssertTrue(sut.rhs?.formatted() == Decimal(0.123456789).formatted())
        XCTAssertTrue(sut.lcdDisplayText == "0.123457")
    }

    // MARK: - Pressing Decimal Immediately

    func testLHS_press_decimal_1() throws {
        sut.decimalPressed()
        sut.numberPressed(1)

        XCTAssertTrue(sut.lhs == Decimal(0.1))
        XCTAssertTrue(sut.lcdDisplayText == "0.1")
    }

    func testRHS_press_decimal_1() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.decimalPressed()
        sut.numberPressed(1)
        XCTAssertTrue(sut.rhs == Decimal(0.1))
        XCTAssertTrue(sut.lcdDisplayText == "0.1")
    }

    // MARK: - Executed Equations

    func testExecutedEquations1() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.equalsPressed()

        sut.decimalPressed()
        sut.numberPressed(1)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.1)))
        XCTAssertTrue(sut.lcdDisplayText == "0.1")
    }

    func testExecutedEquations2() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.equalsPressed()

        sut.decimalPressed()
        sut.numberPressed(1)

        sut.addPressed()

        sut.decimalPressed()
        sut.numberPressed(1)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.1)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.1)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0.2)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.2")
    }

    func testExecutedEquations3() throws {
        sut.decimalPressed()
        sut.numberPressed(6)
        sut.numberPressed(4)

        sut.addPressed()

        sut.decimalPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        sut.decimalPressed()
        sut.numberPressed(1)

        sut.addPressed()

        sut.decimalPressed()
        sut.numberPressed(1)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.1)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.1)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0.2)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.2")
    }

    func testExecutedEquations4() throws {
        sut.decimalPressed()
        sut.numberPressed(6)
        sut.numberPressed(4)

        sut.addPressed()

        sut.decimalPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        sut.addPressed()

        sut.decimalPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(1.04)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.4)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(1.44)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "1.44")
    }

    // MARK: - Test Decimal Math

    func testDecimalMath1() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(6)

        sut.addPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.6)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.4)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "1")
    }

    func testDecimalMath2() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(6)
        sut.numberPressed(6)
        sut.numberPressed(6)

        sut.addPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(4)
        sut.numberPressed(6)
        sut.numberPressed(6)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.666)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.466)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(1.132)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "1.132")
    }

    func testDecimalMath3() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(6)

        sut.addPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(6)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.06)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.06)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0.12)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.12")
    }

    func testDecimalMath4() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(6)

        sut.addPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(6)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.006)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0.006)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0.012)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "0.012")
    }

    func testDecimalMath5() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(6)

        sut.addPressed()

        sut.numberPressed(0)
        sut.decimalPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(6)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.formatted() == Decimal(0.0006).formatted())
        XCTAssertTrue(sut.rhs?.formatted() == Decimal(0.0006).formatted())
        XCTAssertTrue(sut.result?.formatted() == Decimal(0.0012).formatted())
        XCTAssertTrue(sut.lcdDisplayText == "0.0012")
    }
}
