//
//  ReactiveThemeManager.swift
//  123Calc
//
//  Created by Matt Harding on 17/10/2023.
//

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
