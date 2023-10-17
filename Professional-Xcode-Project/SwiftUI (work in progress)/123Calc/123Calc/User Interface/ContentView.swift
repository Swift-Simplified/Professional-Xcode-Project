//
//  ContentView.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var calculatorEngine: ReactiveCalculatorAPI
    
//    init(calculatorEngine: CalculatorAPI) {
//        /// We need to manually initialise the ViewModel StateObjects here so we can inject the Calculator Engine
//        /// This StateObject will only be initialised once at the beginning of the view lifetime
//        /// (not every time the view is refreshed / init is called)
//        /// See https://sarunw.com/posts/manually-initialize-stateobject/ for further info and Apple's view that this is an "officially supported" approach
//        self._viewModel = StateObject(wrappedValue: ViewModel(calculatorEngine: calculatorEngine))
//    }
    
    // MARK: - Size Properties
    let buttonSize = CGSize(width: 78, height: 78)
    
    var body: some View {
        VStack {
            Text(calculatorEngine.lcdDisplayText)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .font(.system(size: 90))

            HStack {
                Group {
                    pinPadButton({
                        calculatorEngine.clearPressed()
                    }, label: "AC")
                    pinPadButton({
                        calculatorEngine.negatePressed()
                    }, label: "⁺∕₋")
                    pinPadButton({
                        calculatorEngine.percentagePressed()
                    }, label: "%")
                    pinPadButton({
                        calculatorEngine.dividePressed()
                    }, label: "÷")
                }
            }
            
            HStack {
                Group {
                    pinPadButton({
                        calculatorEngine.numberPressed(7)
                    }, label: "7")
                    pinPadButton({
                        calculatorEngine.numberPressed(8)
                    }, label: "8")
                    pinPadButton({
                        calculatorEngine.numberPressed(9)
                    }, label: "9")
                    pinPadButton({
                        calculatorEngine.multiplyPressed()
                    }, label: "X")
                }
            }
            
            HStack {
                Group {
                    pinPadButton({
                        calculatorEngine.numberPressed(4)
                    }, label: "4")
                    pinPadButton({
                        calculatorEngine.numberPressed(5)
                    }, label: "5")
                    pinPadButton({
                        calculatorEngine.numberPressed(6)
                    }, label: "6")
                    pinPadButton({
                        calculatorEngine.minusPressed()
                    }, label: "-")
                }
            }
            
            HStack {
                Group {
                    pinPadButton({
                        calculatorEngine.numberPressed(1)
                    }, label: "1")
                    pinPadButton({
                        calculatorEngine.numberPressed(2)
                    }, label: "2")
                    pinPadButton({
                        calculatorEngine.numberPressed(3)
                    }, label: "3")
                    pinPadButton({
                        calculatorEngine.addPressed()
                    }, label: "+")
                }
            }
            
            HStack {
                Group {
                    pinPadButton({
                        calculatorEngine.numberPressed(0)
                    }, label: "0", widthModifier: 2.1)
                    pinPadButton({
                        calculatorEngine.decimalPressed()
                    }, label: ".")
                    pinPadButton({
                        calculatorEngine.equalsPressed()
                    }, label: "=")
                }
            }
        }
    }
    
    @ViewBuilder func pinPadButton(_ action: @escaping () -> Void, label: String, widthModifier: CGFloat = 1) -> some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .frame(width: buttonSize.width * widthModifier, height: buttonSize.height)
               .background(Color.green)
               .foregroundColor(Color.white)
               .cornerRadius(10)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(calculatorEngine: ReactiveCalculatorAPI())
    }
}
