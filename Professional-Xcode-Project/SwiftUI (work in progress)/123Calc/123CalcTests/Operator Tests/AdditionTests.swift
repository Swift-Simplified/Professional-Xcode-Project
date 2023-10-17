//
//  AdditionTests.swift
//  Calc123Tests
//
//  Created by Matthew Harding (Swift engineer & online instructor) on 25/01/2023
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
//   It's our testing team! They are testing pressing the add button.
//   Architectural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests provides more confidence in our code. We can be sure
//      it functions as expected and sleep easier at night too.
// -------------------------------------------------------------------------------------------


import XCTest
@testable import Calc123

class AdditionTests: XCTestCase {

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
    
    func testBasicMath() throws {
        sut.numberPressed(1)
        sut.addPressed()
        sut.numberPressed(1)
        sut.equalsPressed()
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(1)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(2)) ?? false)
    }
    
    // MARK: - Continuously Start New Equations
    
    func testContinuouslyStartingNewEquations() throws {
        continuouslyStartNewEquations(using: 1)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 2)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 3)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 4)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 5)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 6)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 7)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 8)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 9)
        tearDown(); setUp();
        continuouslyStartNewEquations(using: 0)
    }
    
    private func continuouslyStartNewEquations(using number: Int) {
        
        for iteration in 0...9 {
            sut.numberPressed(number)
            sut.addPressed()
            sut.numberPressed(iteration)
            sut.equalsPressed()
            
            XCTAssertTrue(sut.lhs.isEqual(to: Decimal(number)))
            XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(sut.result?.isEqual(to: Decimal(number + iteration)) ?? false)
        }
        
    }
    
    // MARK: - Continuously Add From Result
    
    func test_addingTheResult() throws {
        continuouslyAddResult(startingWith: 1)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 2)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 3)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 4)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 5)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 6)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 7)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 8)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 9)
        tearDown(); setUp();
        continuouslyAddResult(startingWith: 0)
    }
    
    private func continuouslyAddResult(startingWith number: Int) {
        sut.numberPressed(number)
        
        var currentResult = Decimal(number)
        for iteration in 0...9 {
            sut.addPressed()
            sut.numberPressed(iteration)
            sut.equalsPressed()
            
            guard let result = sut.result else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            XCTAssertTrue(sut.lhs.isEqual(to: currentResult))
            XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(result.isEqual(to: currentResult + Decimal(iteration)))
            
            currentResult = result
        }
    }
    
    // MARK: - Random Equation
    
    func testRandomEquation() throws {
        sut.numberPressed(7)
        sut.addPressed()
        sut.numberPressed(1)
        sut.numberPressed(2)
        sut.numberPressed(7)
        sut.equalsPressed()
        
        sut.addPressed()
        sut.numberPressed(3)
        sut.numberPressed(4)
        sut.equalsPressed()

        sut.addPressed()
        sut.numberPressed(6)
        sut.equalsPressed()
        
        sut.addPressed()
        sut.numberPressed(5)
        sut.equalsPressed()
        
        sut.addPressed()
        sut.numberPressed(4)
        sut.equalsPressed()
        
        sut.addPressed()
        sut.numberPressed(3)
        sut.equalsPressed()
        
        sut.addPressed()
        sut.numberPressed(2)
        sut.equalsPressed()
        
        XCTAssertTrue(sut.lhs.isEqual(to: Decimal(186)))
        XCTAssertTrue(sut.rhs?.isEqual(to: Decimal(2)) ?? false)
        XCTAssertTrue(sut.result?.isEqual(to: Decimal(188)) ?? false)
    }
}
