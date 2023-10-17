//
//  ContentView.swift
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
//   This file outlines the instructions for displaying our data inside this view.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import SwiftUI

struct ContentView: View {
    // MARK: Datasource Properties

    @ObservedObject var calc: ReactiveCalculator
    @ObservedObject var themeManager: ReactiveThemeManager
    private let buttonSize = CGSize(width: 78, height: 78)

    // MARK: Main View Builder

    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 20)
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
                Spacer(minLength: 20)
            }
            .background(Color(hex: themeManager.currentTheme.background))
            Color(hex: themeManager.currentTheme.background)
                .ignoresSafeArea()
        }
        .preferredColorScheme(themeManager.currentTheme.statusBarStyle == .dark ? .light : .dark)
    }

    // MARK: Button Builders

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

    // MARK: Changing Themes

    private func rotateToNextTheme() {
        themeManager.moveToNextTheme()
    }
}

// MARK: - Previews - Development Feature (for when canvas is enabled)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            calc: ReactiveCalculator(),
            themeManager: ReactiveThemeManager()
        )
    }
}
