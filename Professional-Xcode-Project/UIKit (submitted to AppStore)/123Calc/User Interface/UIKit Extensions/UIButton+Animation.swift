//
//  UIButton+Animation.swift
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
//   It's an extension. It adds more features to UIButton, such as animation.
//   Architectural Layer: The user interface (UI) of the app.
//
//   💡 Tip 👉🏻 Animations provide personality. They emotionally connect the product to the
//   audience and give the app a certain "feel". Adding animations is a great idea.
// -------------------------------------------------------------------------------------------

import UIKit

extension UIButton {
    func bounce() {
        UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseOut, .allowUserInteraction]) { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self?.alpha = 1
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: { [weak self] in
                self?.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}
