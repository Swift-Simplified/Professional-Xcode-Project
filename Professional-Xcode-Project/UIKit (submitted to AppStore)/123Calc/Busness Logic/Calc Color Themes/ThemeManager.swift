//
//  ThemeManager.swift
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
//   It's a color theme manager, it stores all of our color themes.
//   Architectural Layer: Business Logic Layer
//
// -------------------------------------------------------------------------------------------

import Foundation

class ThemeManager {
    // MARK: - Properties

    private let dataStore = DataStoreManager(key: ThemeManager.keys.dataStore)

    // MARK: - 👇🏽 The Singleton Design Pattern

    static let shared = ThemeManager() // → 💡 Tip: This is a Singleton. The singleton design pattern is being phased out of commercial projects, however you WILL see it in industry! So let's use it in this project and gain some experience of how it works. 😃

    // MARK: - Theme Options

    private(set) var themes: [CalculatorTheme] = []

    // MARK: - Accessing The Current Theme

    private var savedTheme: CalculatorTheme?
    var currentTheme: CalculatorTheme {
        guard let theme = savedTheme else {
            guard let firstThemeOption = themes.first else {
                return ThemeLoader().appBrandTheme
            }
            return firstThemeOption
        }

        return theme
    }

    // MARK: - Initialiser

    init() {
        restoreSavedTheme()
        populateSelectionOfThemes()
    }

    // MARK: - Populate Theme Selection

    private func populateSelectionOfThemes() {
        themes = ThemeLoader().allThemes
    }

    // MARK: - Save & Restore From Disk

    private func saveThemeToDisk(_ theme: CalculatorTheme) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(theme) {
            dataStore.set(encoded)
        }
    }

    private func restoreSavedTheme() {
        if let previousTheme = readSavedThemeFromDisk() {
            savedTheme = previousTheme
        }
    }

    private func readSavedThemeFromDisk() -> CalculatorTheme? {
        guard let savedTheme = dataStore.getValue() as? Data else {
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(CalculatorTheme.self, from: savedTheme)
    }

    // MARK: - Changing Themes

    func moveToNextTheme() {
        let themeID = currentTheme.id
        let index = themes.firstIndex { calculatorTheme in
            calculatorTheme.id == themeID
        }

        // → The user is using a theme which has been removed. Reset to the first theme.
        guard let indexOfExistingTheme = index else {
            if let firstTheme = themes.first {
                updateSystemWithTheme(firstTheme)
            }
            return
        }

        // → Move to the next theme
        var nextThemeIndex = indexOfExistingTheme + 1
        if nextThemeIndex > themes.count - 1 {
            nextThemeIndex = 0
        }
        guard let nextTheme = themes[safe: nextThemeIndex] else {
            return
        }

        updateSystemWithTheme(nextTheme)
    }

    // MARK: - Set A New Theme

    private func updateSystemWithTheme(_ theme: CalculatorTheme) {
        savedTheme = theme
        saveThemeToDisk(theme)
    }
}
