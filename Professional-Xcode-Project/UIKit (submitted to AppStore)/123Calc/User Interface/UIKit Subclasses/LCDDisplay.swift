//
//  LCDDisplay.swift
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
//   It's a subclass. This is our label to display input and the results of equations.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import UIKit

class LCDDisplay: UIView {
    // MARK: - IBOutlets

    @IBOutlet var label: UILabel! // → 💡 Tip: Unwrapping Optionals - If this label is not connected then the app will crash!

    // MARK: - Properties

    var historyMenuItem: UIMenuItem {
        return UIMenuItem(title: "View Log", action: #selector(self.displayMathEquationHistory(_:)))
    }

    // MARK: - Initialisers

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    private func sharedInit() {
        layer.cornerRadius = 20
        layer.masksToBounds = true
        setupBackgroundColorInOrderToAnimate()
        addMenuGestureRecogniser()
    }

    private func setupBackgroundColorInOrderToAnimate() {
        backgroundColor = .clear
    }

    // MARK: - Notifications

    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(willHideEditMenu(_:)), name: UIMenuController.willHideMenuNotification, object: nil)
    }

    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIMenuController.willHideMenuNotification, object: nil)
    }

    // MARK: - Gesture Recogniser

    private func addMenuGestureRecogniser() {
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureEventFired)))
    }

    @objc private func longPressGestureEventFired(_ recognizer: UILongPressGestureRecognizer) {
        guard UIMenuController.shared.isMenuVisible == false else {
            return
        }

        showMenu(from: recognizer)
    }

    // MARK: - UIMenuController

    @objc private func showMenu(from recognizer: UILongPressGestureRecognizer) {
        registerNotifications()
        becomeFirstResponder()

        let menu = UIMenuController.shared
        menu.menuItems = [historyMenuItem]

        let locationOfTouchInLabel = recognizer.location(in: self)

        if !menu.isMenuVisible {
            var rect = bounds
            rect.origin = locationOfTouchInLabel
            rect.origin.y = rect.origin.y - 20
            rect.size = CGSize(width: 1, height: 44)
            menu.showMenu(from: self, rect: rect)
        }

        highlightScreen()
    }

    private func hideMenu() {
        UIMenuController.shared.hideMenu()
        resignFirstResponder()
        unregisterNotifications()
    }

    @objc override func copy(_: Any?) {
        UIPasteboard.general.string = label.text
        hideMenu()
    }

    @objc override func paste(_: Any?) {
        guard let numberToPaste = UIPasteboard.general.string?.doubleValue else { return }

        hideMenu()

        let userInfo: [AnyHashable: Any] = [LCDDisplay.keys.userInfo: numberToPaste]
        NotificationCenter.default.post(name: Notification.Name(LCDDisplay.keys.pasteNumberNotification), object: nil, userInfo: userInfo)
    }

    @objc private func displayMathEquationHistory(_: Any?) {
        hideMenu()
        NotificationCenter.default.post(name: Notification.Name(LCDDisplay.keys.historyLogNotification), object: nil)
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender _: Any?) -> Bool {
        return action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(displayMathEquationHistory(_:))
    }

    @objc private func willHideEditMenu(_: Notification) {
        unhighlightScreen(true)
    }

    // MARK: - Animation

    private func highlightScreen() {
        let theme = ThemeManager.shared.currentTheme

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.layer.backgroundColor = UIColor(hex: theme.operatorNormal)?.cgColor
            self?.label.textColor = UIColor(hex: theme.operatorTitle)
        } completion: { _ in
        }
    }

    private func unhighlightScreen(_ animated: Bool) {
        let theme = ThemeManager.shared.currentTheme

        let actionToPerform: (() -> Void) = { [weak self] in
            self?.layer.backgroundColor = UIColor.clear.cgColor
            self?.label.textColor = UIColor(hex: theme.display)
        }

        guard animated else {
            actionToPerform()
            return
        }

        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut) {
            actionToPerform()
        } completion: { _ in
        }
    }

    // MARK: - Themes

    func prepareForThemeUpdate() {
        unhighlightScreen(false)
        hideMenu()
    }
}
