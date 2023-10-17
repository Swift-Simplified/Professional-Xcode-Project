//
//  DisplayTests.swift
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
//   It's our testing team! They are testing pressing the display panel (LCD Display).
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------


import XCTest
@testable import Calc123

class DisplayTests: XCTestCase {
    
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
    
    // MARK: - NaN
    
    func testNan() throws {
        sut.numberPressed(0)
        sut.dividePressed()
        sut.numberPressed(0)
        sut.equalsPressed()
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(0)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(0)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal.nan) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "Error")
    }
    
    // MARK: - Decimal
    
    func testDecimalOnlyPressed() throws {
        sut.decimalPressed()
        
        XCTAssertTrue(sut.lcdDisplayText == "0.")
    }

    func testDecimal() throws {
        sut.numberPressed(0)
        sut.decimalPressed()
        
        XCTAssertTrue(sut.lcdDisplayText == "0.")
    }
    
    // MARK: - Numbers - Left
    
    func testLHS_0() throws {
        sut.numberPressed(0)
        
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }
    
    func testLHS_1() throws {
        sut.numberPressed(1)
        
        XCTAssertTrue(sut.lcdDisplayText == "1")
    }
    
    func testLHS_2() throws {
        sut.numberPressed(2)
        
        XCTAssertTrue(sut.lcdDisplayText == "2")
    }
    
    func testLHS_3() throws {
        sut.numberPressed(3)
        
        XCTAssertTrue(sut.lcdDisplayText == "3")
    }
    
    func testLHS_4() throws {
        sut.numberPressed(4)
        
        XCTAssertTrue(sut.lcdDisplayText == "4")
    }
    
    func testLHS_5() throws {
        sut.numberPressed(5)
        
        XCTAssertTrue(sut.lcdDisplayText == "5")
    }
    
    func testLHS_6() throws {
        sut.numberPressed(6)
        
        XCTAssertTrue(sut.lcdDisplayText == "6")
    }
    
    func testLHS_7() throws {
        sut.numberPressed(7)
        
        XCTAssertTrue(sut.lcdDisplayText == "7")
    }
    
    func testLHS_8() throws {
        sut.numberPressed(8)
        
        XCTAssertTrue(sut.lcdDisplayText == "8")
    }
    
    func testLHS_9() throws {
        sut.numberPressed(9)
        
        XCTAssertTrue(sut.lcdDisplayText == "9")
    }
    
    // MARK: - Numbers - Right
    
    func testRHS_0() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(0)
        
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }
    
    func testRHS_1() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(1)
        
        XCTAssertTrue(sut.lcdDisplayText == "1")
    }
    
    func testRHS_2() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(2)
        
        XCTAssertTrue(sut.lcdDisplayText == "2")
    }
    
    func testRHS_3() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(3)
        
        XCTAssertTrue(sut.lcdDisplayText == "3")
    }
    
    func testRHS_4() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(4)
        
        XCTAssertTrue(sut.lcdDisplayText == "4")
    }
    
    func testRHS_5() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(5)
        
        XCTAssertTrue(sut.lcdDisplayText == "5")
    }
    
    func testRHS_6() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(6)
        
        XCTAssertTrue(sut.lcdDisplayText == "6")
    }
    
    func testRHS_7() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(7)
        
        XCTAssertTrue(sut.lcdDisplayText == "7")
    }
    
    func testRHS_8() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(8)
        
        XCTAssertTrue(sut.lcdDisplayText == "8")
    }
    
    func testRHS_9() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(9)
        
        XCTAssertTrue(sut.lcdDisplayText == "9")
    }
    
    // MARK: - Consecutive Numbers - Left
    
    func testLHS_000() throws {
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }
    
    func testLHS_111() throws {
        sut.numberPressed(1)
        sut.numberPressed(1)
        sut.numberPressed(1)
        
        XCTAssertTrue(sut.lcdDisplayText == "111")
    }
    
    func testLHS_222() throws {
        sut.numberPressed(2)
        sut.numberPressed(2)
        sut.numberPressed(2)
        
        XCTAssertTrue(sut.lcdDisplayText == "222")
    }
    
    func testLHS_333() throws {
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        
        XCTAssertTrue(sut.lcdDisplayText == "333")
    }
    
    func testLHS_444() throws {
        sut.numberPressed(4)
        sut.numberPressed(4)
        sut.numberPressed(4)
        
        XCTAssertTrue(sut.lcdDisplayText == "444")
    }
    
    func testLHS_555() throws {
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        
        XCTAssertTrue(sut.lcdDisplayText == "555")
    }
    
    func testLHS_666() throws {
        sut.numberPressed(6)
        sut.numberPressed(6)
        sut.numberPressed(6)
        
        XCTAssertTrue(sut.lcdDisplayText == "666")
    }
    
    func testLHS_777() throws {
        sut.numberPressed(7)
        sut.numberPressed(7)
        sut.numberPressed(7)
        
        XCTAssertTrue(sut.lcdDisplayText == "777")
    }
    
    func testLHS_888() throws {
        sut.numberPressed(8)
        sut.numberPressed(8)
        sut.numberPressed(8)
        
        XCTAssertTrue(sut.lcdDisplayText == "888")
    }
    
    func testLHS_999() throws {
        sut.numberPressed(9)
        sut.numberPressed(9)
        sut.numberPressed(9)
        
        XCTAssertTrue(sut.lcdDisplayText == "999")
    }
    
    // MARK: - Consecutive Numbers - Right
    
    func testRHS_000() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(0)
        sut.numberPressed(0)
        sut.numberPressed(0)
        
        XCTAssertTrue(sut.lcdDisplayText == "0")
    }
    
    func testRHS_111() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(1)
        sut.numberPressed(1)
        
        XCTAssertTrue(sut.lcdDisplayText == "111")
    }
    
    func testRHS_222() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(2)
        sut.numberPressed(2)
        sut.numberPressed(2)
        
        XCTAssertTrue(sut.lcdDisplayText == "222")
    }
    
    func testRHS_333() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(3)
        sut.numberPressed(3)
        
        XCTAssertTrue(sut.lcdDisplayText == "333")
    }
    
    func testRHS_444() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(4)
        sut.numberPressed(4)
        sut.numberPressed(4)
        
        XCTAssertTrue(sut.lcdDisplayText == "444")
    }
    
    func testRHS_555() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        
        XCTAssertTrue(sut.lcdDisplayText == "555")
    }
    
    func testRHS_666() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(6)
        sut.numberPressed(6)
        sut.numberPressed(6)
        
        XCTAssertTrue(sut.lcdDisplayText == "666")
    }
    
    func testRHS_777() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(7)
        sut.numberPressed(7)
        sut.numberPressed(7)
        
        XCTAssertTrue(sut.lcdDisplayText == "777")
    }
    
    func testRHS_888() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(8)
        sut.numberPressed(8)
        sut.numberPressed(8)
        
        XCTAssertTrue(sut.lcdDisplayText == "888")
    }
    
    func testRHS_999() throws {
        sut.numberPressed(0)
        sut.addPressed()
        sut.numberPressed(9)
        sut.numberPressed(9)
        sut.numberPressed(9)
        
        XCTAssertTrue(sut.lcdDisplayText == "999")
    }
    
    // MARK: - Result
    
    func testResultInTheThousands() throws {
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.addPressed()
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.numberPressed(5)
        sut.equalsPressed()
        
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(1110)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "1,110")
    }
    
    func testResultInTheMillions() throws {
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
        
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(1111110)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "1,111,110")
    }
    
    func testResultInTheBillions() throws {
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
        
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(1111111110)) ?? false)
        XCTAssertTrue(sut.lcdDisplayText == "1,111,111,110")
    }
}
