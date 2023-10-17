//
//  ReactiveThemeManager.swift
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
//   It's a class created to be an adapter between the Calculator system and the reactive
//   SwiftUI framework in order to automatically trigger our SwiftUI Views to redraw
//   themselves.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import Foundation

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
