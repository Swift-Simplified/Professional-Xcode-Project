//: ## ![SwiftSimplified.com](swift-simplified-logo.png)
//:
//: ![Swift Simplified .com](ss-in-content-logo.png) [Swift Simplified .com](https://www.swiftsimplified.com)
//:
//: [Swift.org](https://www.swift.org) | [SwiftSimplified.com](https://www.swiftsimplified.com) | [Online Swift Course](https://www.swiftsimplified.com/the-swift-handbook) | [Swift Language Guide](https://www.swiftsimplified.com/the-swift-language-guide)
//:
//: -------------------
//: ## 123 Calc App
//:
//: This professionally written AppStore-quality app was written so that the main "system" or "business logic" could be plugged in to a UI *(User Interface)*.
//:
//: This means that the `CalculatorAPI` *(the interface to the system)* has been written as if buttons were going to be pressed to generate a basic math equation.
//:
//: ![123Calc screenshot](Calc123-UI.png)
//: -------------------
//: ## 🏛 123 Calc Architecture
//: This calculator app is divided into 4 main parts:
//: * Visual UI layer - *the UI (User Interface)*
//: * Calculator - *the interface of the whole system coordinating actions triggered by input*
//: * EquationBuilder - *a manager building an equation from user input*
//: * Equation - *a raw math equation*
/*
 
123 Calc App Architecture
            _________________________________________
Layer 4   → |            Visual UI layer            |  Tier 4 - UI (User Interface)
            -----------------------------------------
            ___________________↑_↓___________________
Layer 3   → |               Calculator              |  Tier 3 - Calculator Interface
            -----------------------------------------
            ___________________↑_↓___________________
Layer 2   → |             EquationBuilder           |  Tier 2 - Managing User Input Building An Equation
            -----------------------------------------
            ___________________↑_↓___________________
Layer 1   → |                Equation               |  Tier 1 - Raw Math Equation
            -----------------------------------------
 
 */
//: ## 🏛 Simplified Overview
//: To help demonstrate the architecture used in this Xcode project we have re-implemented the solution again below. This over-simplified version of a calculator has less features than the 123Calc app and doesn't account for all scenarios. However, it's a very effective example of the responsibility of each component and how they're all put together.
// MARK: - A Simplified Overview
import Foundation // includes the Decimal type

// MARK: - 📦 Layer 1 - Equation

enum ExampleOperation {
    case add
    case subtract
    case divide
    case multiply
}

struct ExampleEquation {
    var lhs: Decimal = 0
    var rhs: Decimal?
    var result: Decimal?
    var operation: ExampleOperation?
    
    mutating func execute() {
        guard let operation,
        let rhs else {
            return
        }
        switch operation {
        case .add: result = lhs + rhs
        case .subtract: result = lhs - rhs
        case .divide: result = lhs / rhs
        case .multiply: result = lhs * rhs
        }
    }
}

// MARK: 📦 Layer 2 - EquationBuilder

import Darwin // includes more math functions i.e. pow(a, b)
class ExampleEquationBuilder {
    
    // MARK: - Operation Side Enum
    
    enum OperandSide {
        case leftHandSide
        case rightHandSide
    }

    // MARK: - variables
    
    private(set) var equation = ExampleEquation()
    private var editingSide: OperandSide = .leftHandSide
    private var isEnteringDecimal = false
    private var currentDecimalPlaces = 1
    
    // MARK: - Decimal Numbers
    
    func applyDecimalPoint() {
        isEnteringDecimal = true
        if editingSide == .rightHandSide,
           equation.rhs == nil {
            equation.rhs = Decimal(0)
        }
    }
    
    // MARK: - Math Operations
    
    func divide() {
        equation.operation = .divide
        startEditingRightHandSide()
    }
    
    func add() {
        equation.operation = .add
        startEditingRightHandSide()
    }
    
    func subtract() {
        equation.operation = .subtract
        startEditingRightHandSide()
    }
    
    func multiply() {
        equation.operation = .multiply
        startEditingRightHandSide()
    }
    
    func execute() {
        equation.execute()
    }
    
    func enterNumber(_ number: Int) {
        switch editingSide {
        case .leftHandSide:
            let previousInput = equation.lhs
            equation.lhs = appendNewNumber(number, toPreviousEntry: previousInput)
        case .rightHandSide:
            let previousInput = equation.rhs ?? Decimal.zero
            equation.rhs = appendNewNumber(number, toPreviousEntry: previousInput)
        }
    }
    
    private func appendNewNumber(_ number: Int, toPreviousEntry previousInput: Decimal) -> Decimal {
        guard isEnteringDecimal == false else {
            return appendNewDecimal(number, toPreviousEntry: previousInput)
        }
        return (previousInput * 10) + Decimal(number)
    }
    
    private func appendNewDecimal(_ number: Int, toPreviousEntry previousInput: Decimal) -> Decimal {
        let newDecimalNumber = Decimal(number) / Decimal(pow(10.0, Double(currentDecimalPlaces)))
        currentDecimalPlaces += 1
        return previousInput + newDecimalNumber
    }
    
    var result: Decimal? {
        return equation.result
    }
    
    private func startEditingRightHandSide() {
        editingSide = .rightHandSide
        isEnteringDecimal = false
        currentDecimalPlaces = 1
    }
}

// MARK: - 📦 Layer 3 - Calculator

class ExampleCalculator {
    private(set) var equationBuilder = ExampleEquationBuilder()
    
    // MARK: - Calculator API
    
    func clearPressed() {
        equationBuilder = ExampleEquationBuilder()
    }

    func numberPressed(_ number: Int) {
        equationBuilder.enterNumber(number)
    }
    
    func decimalPressed() {
        equationBuilder.applyDecimalPoint()
    }
        
    func addPressed() {
        equationBuilder.add()
    }
    
    func minusPressed() {
        equationBuilder.subtract()
    }
    
    func multiplyPressed() {
        equationBuilder.multiply()
    }
    
    func dividePressed() {
        equationBuilder.divide()
    }
    
    func equalsPressed() {
        equationBuilder.execute()
    }
    
    var result: Decimal? {
        equationBuilder.result
    }
    
    // MARK: - LCD Display
    var lcdDisplayText: String {
        if let result = equationBuilder.equation.result?.formatted() {
            return result
        }
        if let rightOperand = equationBuilder.equation.result?.formatted() {
            return rightOperand
        }
        return equationBuilder.equation.lhs.formatted()
    }
}

// MARK: - 📦 Layer 4 - UI (User Interface)

class UserInterface {
    // properties
    let calc = ExampleCalculator()
    var textToDisplay = ""
    
    // functions connected to UI buttons
    func refreshDisplay() {
        textToDisplay = calc.lcdDisplayText
    }
    
    // numeric keyboard
    func numberPressed(_ number: Int) {
        calc.numberPressed(number)
        refreshDisplay()
    }
    func zeroPressed() {
        numberPressed(0)
    }
    func onePressed() {
        numberPressed(1)
    }
    func twoPressed() {
        numberPressed(2)
    }
    func threePressed() {
        numberPressed(3)
    }
    func fourPressed() {
        numberPressed(4)
    }
    func fivePressed() {
        numberPressed(5)
    }
    func sixPressed() {
        numberPressed(6)
    }
    func sevenPressed() {
        numberPressed(7)
    }
    func eightPressed() {
        numberPressed(8)
    }
    func ninePressed() {
        numberPressed(9)
    }
    // decimal point
    func decimalPressed() {
        calc.decimalPressed()
        refreshDisplay()
    }
    // math operations
    func addPressed() {
        calc.addPressed()
        refreshDisplay()
    }
    func minusPressed() {
        calc.minusPressed()
        refreshDisplay()
    }
    func divisionPressed() {
        calc.dividePressed()
        refreshDisplay()
    }
    func multiplicationPressed() {
        calc.multiplyPressed()
        refreshDisplay()
    }
    // equals
    func equalsPressed() {
        calc.equalsPressed()
        refreshDisplay()
    }
    // extra functions
    func clearPressed() {
        calc.clearPressed()
        refreshDisplay()
    }
}

// MARK: - Using Our Example
// Let's try it!

let userInterface = UserInterface()
// 9 * 4 = 36
userInterface.ninePressed()           // displays 9
userInterface.multiplicationPressed() // still displays 9
userInterface.fourPressed()           // displays 4
userInterface.equalsPressed()         // displays result which is 36
userInterface.textToDisplay           // displays result which is 36
// << 🔵 Run Point
//:
//: -------------------
//: ## Unit Tests
//: This project was written using TDD *(Test Driven Development)*. This approach is where we write our tests first and then write the code to make them pass. It's a fantastic approach that can provide confidence in the solutions we write helping guide us towards higher quality architecture and more component focussed "plug and play" code structures.
//:
//: In this particular Xcode project *(as it's fairly simple)* we focussed on "black box testing", which tests the main interface to the whole system and not each internal mechanism. This allows us to be confident that the system behaves as intended while also offering the freedom to change "how" the system accomplishes this. Perhaps for more complex systems we may want to individually test each component too.
//:
//: 👉 For more information take a look at our unit tests within the "123CalcTests" folder in the project navigator pane. Our unit tests will look something like the screenshot below.
//:
//: ![Example of a unit test](unit-test-example.png)
//:
//: -------------------
//:
//: ## ![SwiftSimplified.com](swift-simplified-logo.png)
//: [Website](https://www.swiftsimplified.com) | [The Swift Handbook](https://www.swiftsimplified.com/the-swift-handbook) | [The Swift Language Guide](https://www.swiftsimplified.com/the-swift-language-guide)
//:
//: 🛠 *..let's live a better life, by learning Swift*
//:
//: ### 🧕🏻🙋🏽‍♂️👨🏿‍💼👩🏼‍💼👩🏻‍💻💁🏼‍♀️👨🏼‍💼🙋🏻‍♂️🙋🏻‍♀️👩🏼‍💻🙋🏿💁🏽‍♂️🙋🏽‍♀️🙋🏿‍♀️🧕🏾🙋🏼‍♂️
//:
//: Welcome to our community of [SwiftSimplified.com](https://www.swiftsimplified.com) students!
