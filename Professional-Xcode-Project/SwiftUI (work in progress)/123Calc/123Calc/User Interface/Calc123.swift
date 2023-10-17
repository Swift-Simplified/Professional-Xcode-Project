//
//  _23CalcApp.swift
//  123Calc
//
//  Created by Matt Harding on 12/06/2023.
//

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

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
