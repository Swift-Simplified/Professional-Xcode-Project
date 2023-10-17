//
//  EqualsButtonTests.swift
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
//   It's our testing team! They are testing pressing the equals button.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------


import XCTest
@testable import Calc123

class EqualsButtonTests: XCTestCase {
    
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
    
    // MARK: - Basic
    
    func testEquation() throws {
        sut.numberPressed(1)
        sut.minusPressed()
        sut.numberPressed(1)
        sut.equalsPressed()
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(1)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(0)) ?? false)
    }
    
    // MARK: - Continuously Pressing Equals From Result
    
    func testContinuousAddition() throws {
        sut.numberPressed(4)
        sut.addPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        sut.equalsPressed()
        sut.equalsPressed()
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(12)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(16)) ?? false)
    }
    
    func testContinuousSubtraction() throws {
        sut.numberPressed(4)
        sut.minusPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        sut.equalsPressed()
        sut.equalsPressed()
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(-4)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(-8)) ?? false)
    }
    
    func testContinuousMultiplication() throws {
        sut.numberPressed(4)
        sut.multiplyPressed()
        sut.numberPressed(4)
        sut.equalsPressed()

        sut.equalsPressed()
        sut.equalsPressed()
 
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(64)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(256)) ?? false)
    }
    
    func testContinuousDivision() throws {
        sut.numberPressed(4)
        sut.dividePressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        sut.equalsPressed()
        sut.equalsPressed()
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0.25)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(sut.result ==  Decimal(0.0625))
    }
}
