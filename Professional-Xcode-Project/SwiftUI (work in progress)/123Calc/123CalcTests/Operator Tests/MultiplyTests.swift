//
//  MultiplyTests.swift
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
//   It's our testing team! They are testing pressing the multiply button.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------

@testable import Calc123
import XCTest

class MultiplyTests: XCTestCase {
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

    // MARK: - Basic

    func testBasicMath() throws {
        sut.numberPressed(1)
        sut.multiplyPressed()
        sut.numberPressed(1)
        sut.equalsPressed()

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(1)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(1)) ?? false)
    }

    // MARK: - Continuously Start New Equations

    func testContinuouslyStartingNewEquations() throws {
        continuouslyStartNewEquations(using: 1)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 2)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 3)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 4)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 5)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 6)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 7)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 8)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 9)
        tearDown(); setUp()
        continuouslyStartNewEquations(using: 0)
    }

    private func continuouslyStartNewEquations(using number: Int) {
        for iteration in 0 ... 9 {
            sut.numberPressed(number)
            sut.multiplyPressed()
            sut.numberPressed(iteration)
            sut.equalsPressed()

            XCTAssertTrue(sut.lhs.isEqual(to: Decimal(number)))
            XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(sut.result?.isEqual(to: Decimal(number * iteration)) ?? false)
        }
    }

    // MARK: - Continuously Multiply From Result

    func test_multiplyingTheResult() throws {
        continuouslyMultiplyResult(startingWith: 1)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 2)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 3)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 4)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 5)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 6)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 7)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 8)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 9)
        tearDown(); setUp()
        continuouslyMultiplyResult(startingWith: 0)
    }

    private func continuouslyMultiplyResult(startingWith number: Int) {
        sut.numberPressed(number)

        var currentResult = Decimal(number)
        for iteration in 0 ... 9 {
            sut.multiplyPressed()
            sut.numberPressed(iteration)
            sut.equalsPressed()

            guard let result = sut.result else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }

            XCTAssertTrue(sut.lhs.isEqual(to: currentResult))
            XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(result.isEqual(to: currentResult * Decimal(iteration)))

            currentResult = result
        }
    }
}
