//
//  PinPadTests.swift
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
//   It's our testing team! They are testing pressesing all 9 numbers on the pin pad.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------


import XCTest
@testable import Calc123

class PinPadTests: XCTestCase {
    
    // MARK: - System Under Test
    
    var sut: CalculatorAPI!
    
    // MARK: - Setup And Tear Down
    override func setUp() {
        sut = Calc123Engine() {
            MathInputController(equation: MathEquation())
        }
    }
    
    override func tearDown() {
        sut = nil
    }

    // MARK: - Operands - Left
    
    func testLHS_isEqualTo1() throws {
        sut.numberPressed(1)
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(1)))
    }
    
    func testLHS_isEqualTo123() throws {
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(123)))
    }
    
    func testLHS_isEqualTo123456789() throws {
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.numberPressed(5)
        sut.numberPressed(6)
        sut.numberPressed(7)
        sut.numberPressed(8)
        sut.numberPressed(9)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(123456789)))
    }
    
    
    
    // MARK: - Operands - Right
    
    func testRHS_isEqualTo1() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(1)) ?? false)
    }
    
    func testRHS_isEqualTo123() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(123)) ?? false)
    }
    
    func testRHS_isEqualTo123456789() throws {
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

        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(123456789)) ?? false)
    }
    
    // MARK: - Invalid Numbers
    
    func testLHS_outOfRangeLow() throws {
        sut.numberPressed(-1)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
    }
    
    func testLHS_outOfRangeHigh() throws {
        sut.numberPressed(10)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
    }
    
    func testRHS_outOfRangeLow() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(-1)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
    }
    
    func testRHS_outOfRangeHigh() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(10)

        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
    }
}
