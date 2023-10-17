//
//  ContentView.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//
import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
//    @ObservedObject var themeManager: ReactiveThemeManager
    @ObservedObject var calc: ReactiveCalculator
    private let buttonSize = CGSize(width: 78, height: 78) // TODO: How do we resize these buttons based on screen width?
    
    var body: some View {
        VStack {
            Text(calc.lcdDisplayText)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .font(.system(size: 90))
                .minimumScaleFactor(0.5)

            HStack {
                Group {
                    pinPadButton("AC") {
                        calc.clearPressed()
                    }
                    pinPadButton("⁺∕₋") {
                        calc.negatePressed()
                    }
                    pinPadButton("%") {
                        calc.percentagePressed()
                    }
                    pinPadButton("÷") {
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
                    pinPadButton("X") {
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
                    pinPadButton("-") {
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
                    pinPadButton("+") {
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
                    pinPadButton("=") {
                        calc.equalsPressed()
                    }
                }
            }
        }
    }
    
    @ViewBuilder func pinPadButton(_ label: String, widthModifier: CGFloat = 1, _ action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .font(.largeTitle)
                .frame(width: buttonSize.width * widthModifier, height: buttonSize.height)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(calc: ReactiveCalculator())
    }
}
