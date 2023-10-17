//
//  ContentView.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//
import SwiftUI

struct ContentView: View {
    
    // MARK: Properties
    
    @ObservedObject var calculator: ReactiveCalculatorAPI
    private let buttonSize = CGSize(width: 78, height: 78) // TODO: How do we resize these buttons based on screen width?
    
    var body: some View {
        VStack {
            Text(calculator.lcdDisplayText)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .font(.system(size: 90))

            HStack {
                Group {
                    pinPadButton("AC") {
                        calculator.clearPressed()
                    }
                    pinPadButton("⁺∕₋") {
                        calculator.negatePressed()
                    }
                    pinPadButton("%") {
                        calculator.percentagePressed()
                    }
                    pinPadButton("÷") {
                        calculator.dividePressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("7") {
                        calculator.numberPressed(7)
                    }
                    pinPadButton("8") {
                        calculator.numberPressed(8)
                    }
                    pinPadButton("9") {
                        calculator.numberPressed(9)
                    }
                    pinPadButton("X") {
                        calculator.multiplyPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("4") {
                        calculator.numberPressed(4)
                    }
                    pinPadButton("5") {
                        calculator.numberPressed(5)
                    }
                    pinPadButton("6") {
                        calculator.numberPressed(6)
                    }
                    pinPadButton("-") {
                        calculator.minusPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("1") {
                        calculator.numberPressed(1)
                    }
                    pinPadButton("2") {
                        calculator.numberPressed(2)
                    }
                    pinPadButton("3") {
                        calculator.numberPressed(3)
                    }
                    pinPadButton("+") {
                        calculator.addPressed()
                    }
                }
            }
            
            HStack {
                Group {
                    pinPadButton("0", widthModifier: 2.1) {
                        calculator.numberPressed(0)
                    }
                    pinPadButton(".") {
                        calculator.decimalPressed()
                    }
                    pinPadButton("=") {
                        calculator.equalsPressed()
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
                .font(.caption)
                .frame(width: buttonSize.width * widthModifier, height: buttonSize.height)
               .background(Color.green)
               .foregroundColor(Color.white)
               .cornerRadius(10)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(calculator: ReactiveCalculatorAPI())
    }
}
