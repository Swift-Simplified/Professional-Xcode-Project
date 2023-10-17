//
//  _23CalcApp.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//

import SwiftUI

@main
struct Calc123App: App {
    
    let calc = ReactiveCalculator()
    let themeManager = ReactiveThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(calc: calc, themeManager: themeManager)
        }
    }
}
