//
//  Calc123.swift
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
//   This file creates the main window of the app and provides the first view to display.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import SwiftUI

@main
struct Calc123App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let calc = ReactiveCalculator()
    let themeManager = ReactiveThemeManager()

    var body: some Scene {
        WindowGroup {
            ContentView(calc: calc, themeManager: themeManager)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_: UIApplication, supportedInterfaceOrientationsFor _: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
