//
//  ContentView.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//
import SwiftUI


class ReactiveThemeManager: ObservableObject {
    private let themeManager = ThemeManager()
    var currentTheme: CalculatorTheme
    
    init() {
        currentTheme = themeManager.currentTheme
    }
    
    func moveToNextTheme() {
        themeManager.moveToNextTheme()
        refreshCurrentTheme()
    }
    
    private func refreshCurrentTheme() {
        objectWillChange.send()
        currentTheme = themeManager.currentTheme
    }
}

struct ContentView: View {
    
    // MARK: Properties
    @ObservedObject var calc: ReactiveCalculator
    @ObservedObject var themeManager: ReactiveThemeManager
    private let buttonSize = CGSize(width: 78, height: 78) // TODO: How do we resize these buttons based on screen width?
    
    var body: some View {
        VStack {
            Color(hex: themeManager.currentTheme.background)
                .ignoresSafeArea()
            Text(calc.lcdDisplayText)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .font(.system(size: 90))
                .minimumScaleFactor(0.5)
                .foregroundColor(Color(hex: themeManager.currentTheme.display))
                .onTapGesture(count: 2) {
                    rotateToNextTheme()
                }
            HStack {
                Group {
                    extraFeatureButton("AC") {
                        calc.clearPressed()
                    }
                    extraFeatureButton("⁺∕₋") {
                        calc.negatePressed()
                    }
                    extraFeatureButton("%") {
                        calc.percentagePressed()
                    }
                    operatorButton("÷") {
                        calc.dividePressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("7") {
                        calc.numberPressed(7)
                    }
                    pinPadButton("8") {
                        calc.numberPressed(8)
                    }
                    pinPadButton("9") {
                        calc.numberPressed(9)
                    }
                    operatorButton("X") {
                        calc.multiplyPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("4") {
                        calc.numberPressed(4)
                    }
                    pinPadButton("5") {
                        calc.numberPressed(5)
                    }
                    pinPadButton("6") {
                        calc.numberPressed(6)
                    }
                    operatorButton("-") {
                        calc.minusPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("1") {
                        calc.numberPressed(1)
                    }
                    pinPadButton("2") {
                        calc.numberPressed(2)
                    }
                    pinPadButton("3") {
                        calc.numberPressed(3)
                    }
                    operatorButton("+") {
                        calc.addPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("0", widthModifier: 2.1) {
                        calc.numberPressed(0)
                    }
                    pinPadButton(".") {
                        calc.decimalPressed()
                    }
                    operatorButton("=") {
                        calc.equalsPressed()
                    }
                }
            }
            Spacer(minLength: 80)
        }
        .background(Color(hex: themeManager.currentTheme.background))
    }
    
    @ViewBuilder func pinPadButton(_ label: String, widthModifier: CGFloat = 1, _ action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .font(.largeTitle)
                .frame(width: buttonSize.width * widthModifier, height: buttonSize.height)
                .background(Color(hex: themeManager.currentTheme.pinPad))
                .foregroundColor(Color(hex: themeManager.currentTheme.pinPadTitle))
                .cornerRadius(10)
        })
    }
    
    @ViewBuilder func operatorButton(_ label: String, _ action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .font(.largeTitle)
                .frame(width: buttonSize.width, height: buttonSize.height)
                .background(Color(hex: themeManager.currentTheme.operatorNormal))
                .foregroundColor(Color(hex: themeManager.currentTheme.operatorTitle))
                .cornerRadius(10)
        })
    }
    
    @ViewBuilder func extraFeatureButton(_ label: String, _ action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .font(.largeTitle)
                .frame(width: buttonSize.width, height: buttonSize.height)
                .background(Color(hex: themeManager.currentTheme.extraFunctions))
                .foregroundColor(Color(hex: themeManager.currentTheme.extraFunctionsTitle))
                .cornerRadius(10)
        })
    }
    
    private func rotateToNextTheme() {
        themeManager.moveToNextTheme()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            calc: ReactiveCalculator(),
            themeManager: ReactiveThemeManager()
        )
    }
}
