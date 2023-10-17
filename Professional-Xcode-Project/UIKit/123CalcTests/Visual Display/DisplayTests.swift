//
//  DisplayTests.swift
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


import XCTest
@testable import Calc123

class DisplayTests: XCTestCase {
    
    // MARK: - System Under Test
    
    var sut: CalculatorAPI!
    
    // MARK: - Setup And Tear Down
    override func setUp() {
        sut = Calculator() {
            // The calculator doesn't create the EquationBuilder or Equation values internally. This is known as "inversion of control" and is a bit advanced but allows us to provide different implementations of Equation and the EquationBuilder if we wanted to.
            EquationBuilder(equation: Equation())
        }
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - NaN
    
    /// Test the display text contains the word "Error" when representing a nan (not a number).
    func testNanDisplaysAnError() throws {
        // 0 / 0 = nan (not a number)
        sut.numberPressed(0)
        sut.dividePressed()
        sut.numberPressed(0)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.lhs, Decimal(0))
        XCTAssertEqual(sut.rhs, Decimal(0))
        XCTAssertEqual(sut.result, Decimal.nan)
        XCTAssertEqual(sut.lcdDisplayText, "Error")
    }
    
    // MARK: - Decimal
    
    /// Test the display is "0." when the user immediately presses the decimal button without first entering zero.
    func testDecimalPressedImmediately() throws {
        // . = 0.
        sut.decimalPressed()
        XCTAssertEqual(sut.lcdDisplayText, "0.")
        
        // 0 + . = 0.
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed();
        sut.decimalPressed()
        XCTAssertEqual(sut.lcdDisplayText, "0.")
    }

    /// Test the display is "0." when the user immediately presses the decimal button without first entering zero.
    func testDecimal() throws {
        // 0 . = 0.
        sut.numberPressed(0)
        sut.decimalPressed()
        XCTAssertEqual(sut.lcdDisplayText, "0.")
        
        // 0 + 0. = 0.
        sut.clearPressed(); sut.numberPressed(0); sut.addPressed();
        sut.numberPressed(0); sut.decimalPressed()
        XCTAssertEqual(sut.lcdDisplayText, "0.")
    }
    
    // MARK: - Operands - Left Hand Side Of Equation
    
    /// Test the display is "0" when the user enters 0.
    func testZero_leftHandSideOfEquation() throws {
        // 0
        sut.numberPressed(0)
        XCTAssertEqual(sut.lcdDisplayText, "0")
    }
    
    /// Test the display is "1" when the user enters 1.
    func testOne_leftHandSideOfEquation() throws {
        // 1
        sut.numberPressed(1)
        XCTAssertEqual(sut.lcdDisplayText, "1")
    }
    
    /// Test the display is "2" when the user enters 2.
    func testTwo_leftHandSideOfEquation() throws {
        // 2
        sut.numberPressed(2)
        XCTAssertEqual(sut.lcdDisplayText, "2")
    }
    
    /// Test the display is "3" when the user enters 3.
    func testThree_leftHandSideOfEquation() throws {
        // 3
        sut.numberPressed(3)
        XCTAssertEqual(sut.lcdDisplayText, "3")
    }
    
    /// Test the display is "4" when the user enters 4.
    func testFour_leftHandSideOfEquation() throws {
        // 4
        sut.numberPressed(4)
        XCTAssertEqual(sut.lcdDisplayText, "4")
    }
    
    /// Test the display is "5" when the user enters 5.
    func testFive_leftHandSideOfEquation() throws {
        // 5
        sut.numberPressed(5)
        XCTAssertEqual(sut.lcdDisplayText, "5")
    }
    
    /// Test the display is "6" when the user enters 6.
    func testSix_leftHandSideOfEquation() throws {
        // 6
        sut.numberPressed(6)
        XCTAssertEqual(sut.lcdDisplayText, "6")
    }
    
    /// Test the display is "7" when the user enters 7.
    func testSeven_leftHandSideOfEquation() throws {
        // 7
        sut.numberPressed(7)
        XCTAssertEqual(sut.lcdDisplayText, "7")
    }
    
    /// Test the display is "8" when the user enters 8.
    func testEight_leftHandSideOfEquation() throws {
        // 8
        sut.numberPressed(8)
        XCTAssertEqual(sut.lcdDisplayText, "8")
    }
    
    /// Test the display is "9" when the user enters 9.
    func testNine_leftHandSideOfEquation() throws {
        // 9
        sut.numberPressed(9)
        XCTAssertEqual(sut.lcdDisplayText, "9")
    }
    
    // MARK: - Operands - Right Hand Side Of Equation
    
    /// Test the display is "0" when the user enters 0.
    func testZero_rightHandSideOfEquation() throws {
        // 0 + 0 = 0
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(0)
        XCTAssertEqual(sut.lcdDisplayText, "0")
    }
    
    /// Test the display is "1" when the user enters 1.
    func testOne_rightHandSideOfEquation() throws {
        // 0 + 1 = 1
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(1)
        XCTAssertEqual(sut.lcdDisplayText, "1")
    }
    
    /// Test the display is "2" when the user enters 2.
    func testTwo_rightHandSideOfEquation() throws {
        // 0 + 2 = 2
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(2)
        XCTAssertEqual(sut.lcdDisplayText, "2")
    }
    
    /// Test the display is "3" when the user enters 3.
    func testThree_rightHandSideOfEquation() throws {
        // 0 + 3 = 3
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(3)
        XCTAssertEqual(sut.lcdDisplayText, "3")
    }
    
    /// Test the display is "4" when the user enters 4.
    func testFour_rightHandSideOfEquation() throws {
        // 0 + 4 = 4
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(4)
        XCTAssertEqual(sut.lcdDisplayText, "4")
    }
    
    /// Test the display is "5" when the user enters 5.
    func testFive_rightHandSideOfEquation() throws {
        // 0 + 5 = 5
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(5)
        XCTAssertEqual(sut.lcdDisplayText, "5")
    }
    
    /// Test the display is "6" when the user enters 6.
    func testSix_rightHandSideOfEquation() throws {
        // 0 + 6 = 6
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(6)
        XCTAssertEqual(sut.lcdDisplayText, "6")
    }
    
    /// Test the display is "7" when the user enters 7.
    func testSeven_rightHandSideOfEquation() throws {
        // 0 + 7 = 7
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(7)
        XCTAssertEqual(sut.lcdDisplayText, "7")
    }
    
    /// Test the display is "8" when the user enters 8.
    func testEight_rightHandSideOfEquation() throws {
        // 0 + 8 = 8
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(8)
        XCTAssertEqual(sut.lcdDisplayText, "8")
    }
    
    /// Test the display is "9" when the user enters 9.
    func testNine_rightHandSideOfEquation() throws {
        // 0 + 9 = 9
        sut.numberPressed(0); sut.addPressed()
        sut.numberPressed(9)
        XCTAssertEqual(sut.lcdDisplayText, "9")
    }
    
    // MARK: - Consecutive Numbers - Left Hand Side Of Equation
    
    /// Test the display is "0" when the user enters 000.
    func testConsecutiveZeros_leftHandSideOfEquation() throws {
        // 000
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        XCTAssertEqual(sut.lcdDisplayText, "0")
    }
    
    /// Test the display is "1,234,567,890" when the user enters 1234567890.
    func testConsecutiveNumbers_leftHandSideOfEquation() throws {
        // 1234567890
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.numberPressed(5)
        sut.numberPressed(6)
        sut.numberPressed(7)
        sut.numberPressed(8)
        sut.numberPressed(9)
        sut.numberPressed(0)
        
        XCTAssertEqual(sut.lcdDisplayText, "1,234,567,890")
    }
    
    // MARK: - Consecutive Numbers - Right Hand Side Of Equation
    
    /// Test the display is "0" when the user enters 000.
    func testConsecutiveZeros_rightHandSideOfEquation() throws {
        // 1 + 000
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        
        XCTAssertEqual(sut.lcdDisplayText, "0")
    }
    
    /// Test the display is "1,234,567,890" when the user enters 1234567890.
    func testConsecutiveNumbers_rightHandSideOfEquation() throws {
        // 1 + 1234567890
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
        sut.numberPressed(0)
        
        XCTAssertEqual(sut.lcdDisplayText, "1,234,567,890")
    }
    
    // MARK: - Result
    
    /// Test the display is "1,110" when the user enters 1110.
    func testResultInTheThousands() throws {
        // 555 + 555 = 1,110
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.addPressed()
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.result, Decimal(1110))
        XCTAssertEqual(sut.lcdDisplayText, "1,110")
    }
    
    /// Test the display is "1,111,110" when the user enters 1111110.
    func testResultInTheMillions() throws {
        // 555555 + 555555 = 1,111,110
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.addPressed()
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.equalsPressed()
        
        XCTAssertEqual(sut.result, Decimal(1111110))
        XCTAssertEqual(sut.lcdDisplayText, "1,111,110")
    }
    
    /// Test the display is "1,111,111,110" when the user enters 1111111110.
    func testResultInTheBillions() throws {
        // 555555555 + 555555555 = 1,111,111,110
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.addPressed()
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.equalsPressed()

        XCTAssertEqual(sut.result, Decimal(1111111110))
        XCTAssertEqual(sut.lcdDisplayText, "1,111,111,110")
    }
}
