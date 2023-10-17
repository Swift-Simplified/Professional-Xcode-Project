//
//  CalcViewController.swift
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
//   It's a screen. It displays the calculator itself.
//   Architectural Layer: The user interface (UI) of the app.
//
//   💡 Architecture Tip 👉🏻 The UI layer should only contain UI. Don't write any business
//      logic here. Instead, use the UI to trigger the business logic reflecting its
//      current state.
// -------------------------------------------------------------------------------------------

import UIKit

class CalcViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var calculatorView: UIView! // → 💡 Tip: Unwrapping Optionals - if this label is not connected then the app will crash!
    @IBOutlet var lcdDisplay: LCDDisplay!

    @IBOutlet var pinPadButton0: UIButton!
    @IBOutlet var pinPadButton1: UIButton!
    @IBOutlet var pinPadButton2: UIButton!
    @IBOutlet var pinPadButton3: UIButton!
    @IBOutlet var pinPadButton4: UIButton!
    @IBOutlet var pinPadButton5: UIButton!
    @IBOutlet var pinPadButton6: UIButton!
    @IBOutlet var pinPadButton7: UIButton!
    @IBOutlet var pinPadButton8: UIButton!
    @IBOutlet var pinPadButton9: UIButton!
    @IBOutlet var decimalButton: UIButton!

    @IBOutlet var clearButton: UIButton!
    @IBOutlet var negateButton: UIButton!
    @IBOutlet var percentageButton: UIButton!

    @IBOutlet var divideButton: UIButton!
    @IBOutlet var multiplyButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var equalsButton: UIButton!

    @IBOutlet var logoImageview: UIImageView!

    // MARK: - Calculator Engine

    private lazy var calculatorEngine: CalculatorAPI = Calculator {
        EquationBuilder(equation: Equation())
    }

    // MARK: - Gesture Properties

    private var themeGestureRecogniser: UITapGestureRecognizer?

    // MARK: - Welcome Intro

    private var needsToStartWelcomeIntro = true
    private let welcomeLogoAnimator = LogoAnimator()

    func setupLogoAnimator() {
        welcomeLogoAnimator.prepareForAnimation(logoImageview)
    }

    private func playLogoAnimator() {
        welcomeLogoAnimator.beginAnimation()
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addThemeGestureRecogniser()

        registerForNotifications()
        decorateView(withTheme: ThemeManager.shared.currentTheme)
        prepareForWelcomeIntro()
        setupLogoAnimator()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if needsToStartWelcomeIntro {
            needsToStartWelcomeIntro = false
            startWelcomeIntro()
        }
    }

    // MARK: - Decorate

    private func decorateView(withTheme theme: CalculatorTheme) {
        view.backgroundColor = UIColor(hex: theme.background)
        calculatorView.backgroundColor = view.backgroundColor

        lcdDisplay.prepareForThemeUpdate()
        lcdDisplay.backgroundColor = .clear
        lcdDisplay.label.textColor = UIColor(hex: theme.display)
        logoImageview.tintColor = UIColor(hex: theme.operatorNormal)
        decoratePinPadButton(pinPadButton0, true)
        decoratePinPadButton(pinPadButton1, false, true)
        decoratePinPadButton(pinPadButton2, false, true)
        decoratePinPadButton(pinPadButton3, false, true)
        decoratePinPadButton(pinPadButton4)
        decoratePinPadButton(pinPadButton5)
        decoratePinPadButton(pinPadButton6)
        decoratePinPadButton(pinPadButton7)
        decoratePinPadButton(pinPadButton8)
        decoratePinPadButton(pinPadButton9)
        decoratePinPadButton(decimalButton)

        decorateOperatorButton(divideButton, theme: theme)
        decorateOperatorButton(multiplyButton, theme: theme)
        decorateOperatorButton(minusButton, theme: theme)
        decorateOperatorButton(addButton, theme: theme)
        decorateOperatorButton(equalsButton, theme: theme)

        decorateExtraFunctionsButton(clearButton)
        decorateExtraFunctionsButton(negateButton)
        decorateExtraFunctionsButton(percentageButton)
    }

    private func decoratePinPadButton(_ button: UIButton, _ usingSlicedImage: Bool = false, _ using123Colors: Bool = false) {
        let selectedTheme = ThemeManager.shared.currentTheme
        button.backgroundColor = .clear
        let imageName = usingSlicedImage ? UIImage.keys.buttonSliced : UIImage.keys.button
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.tintColor = using123Colors ? UIColor(hex: selectedTheme.pinPad123) : UIColor(hex: selectedTheme.pinPad)
        button.setTitleColor(UIColor(hex: selectedTheme.pinPadTitle), for: .normal)
    }

    private func decorateOperatorButton(_ button: UIButton, theme: CalculatorTheme) {
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(named: UIImage.keys.button), for: .normal)
        button.tintColor = UIColor(hex: theme.operatorNormal)
        button.setTitleColor(UIColor(hex: theme.operatorTitle), for: .normal)
        button.setTitleColor(UIColor(hex: theme.operatorTitleSelected), for: .selected)
        button.setTitleColor(UIColor(hex: theme.operatorTitleSelected), for: .highlighted)
    }

    private func decorateExtraFunctionsButton(_ button: UIButton) {
        let selectedTheme = ThemeManager.shared.currentTheme
        button.backgroundColor = .clear
        button.setBackgroundImage(UIImage(named: UIImage.keys.button), for: .normal)
        button.tintColor = UIColor(hex: selectedTheme.extraFunctions)
        button.setTitleColor(UIColor(hex: selectedTheme.extraFunctionsTitle), for: .normal)
    }

    // MARK: - Select Operator Buttons

    private func deselectOperatorButtons() {
        selectOperatorButton(divideButton, false)
        selectOperatorButton(multiplyButton, false)
        selectOperatorButton(minusButton, false)
        selectOperatorButton(addButton, false)
    }

    private func selectOperatorButton(_ button: UIButton, _ selected: Bool = false) {
        let selectedTheme = ThemeManager.shared.currentTheme
        button.tintColor = selected ? UIColor(hex: selectedTheme.operatorSelected) : UIColor(hex: selectedTheme.operatorNormal)
        button.isSelected = selected
    }

    // MARK: - Gesture Recognisers

    private func addThemeGestureRecogniser() {
        themeGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(themeGestureRecogniserDidTap))
        themeGestureRecogniser?.numberOfTapsRequired = 2
        if let gesture = themeGestureRecogniser {
            lcdDisplay.addGestureRecognizer(gesture)
        }
    }

    @objc private func themeGestureRecogniserDidTap(_: UITapGestureRecognizer) {
        decorateViewWithNextTheme()
    }

    // MARK: - Themes

    private func decorateViewWithNextTheme() {
        ThemeManager.shared.moveToNextTheme()
        refreshViewWithTheme(ThemeManager.shared.currentTheme)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch ThemeManager.shared.currentTheme.statusBarStyle {
        case .light: return .lightContent
        case .dark: return .darkContent
        }
    }

    private func refreshViewWithTheme(_ theme: CalculatorTheme) {
        decorateView(withTheme: theme)
        setNeedsStatusBarAppearanceUpdate()
    }

    // MARK: - Refresh Display

    private func refreshLCDDisplay() {
        lcdDisplay.label.text = calculatorEngine.lcdDisplayText
    }

    // MARK: - IBActions

    @IBAction func clearButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        sender.bounce()

        lcdDisplay.alpha = 0

        fadeInLCDDisplay()
        calculatorEngine.clearPressed()
        refreshLCDDisplay()
    }

    @IBAction func negateButtonPressed(_ sender: UIButton) {
        sender.bounce()
        calculatorEngine.negatePressed()
        refreshLCDDisplay()
    }

    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        sender.bounce()
        calculatorEngine.percentagePressed()
        refreshLCDDisplay()
    }

    @IBAction func divideButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        selectOperatorButton(divideButton, true)

        sender.bounce()
        calculatorEngine.dividePressed()
        refreshLCDDisplay()
    }

    @IBAction func multiplyButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        selectOperatorButton(multiplyButton, true)

        sender.bounce()
        calculatorEngine.multiplyPressed()
        refreshLCDDisplay()
    }

    @IBAction func minusButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        selectOperatorButton(minusButton, true)

        sender.bounce()
        calculatorEngine.minusPressed()
        refreshLCDDisplay()
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        selectOperatorButton(addButton, true)

        sender.bounce()
        calculatorEngine.addPressed()
        refreshLCDDisplay()
    }

    @IBAction func equalButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        sender.bounce()

        calculatorEngine.equalsPressed()
        refreshLCDDisplay()
    }

    @IBAction func decimalButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        sender.bounce()

        calculatorEngine.decimalPressed()
        refreshLCDDisplay()
    }

    @IBAction func numberButtonPressed(_ sender: UIButton) {
        deselectOperatorButtons()
        sender.bounce()
        let number = sender.tag

        calculatorEngine.numberPressed(number)
        refreshLCDDisplay()
    }

    // MARK: - Animate

    // → 💡 Tip: The app-opening experience is important because it creates the initial first impressions to the user.
    //      We can use animations to generate a bit of personality!

    private func fadeInLCDDisplay() {
        UIView.animate(withDuration: 1.0, animations: { [weak self] in
            self?.lcdDisplay.alpha = 1
        })
    }

    private func slideInLCDDisplay() {
        lcdDisplay.transform = CGAffineTransform(translationX: 0, y: lcdDisplay.frame.height * 0.5)
        UIView.animate(withDuration: 0.35, delay: 0.2, options: .curveEaseOut) { [weak self] in

            self?.lcdDisplay.alpha = 1
            self?.lcdDisplay.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { _ in
        }
    }

    private func startWelcomeIntro() {
        if calculatorEngine.restoreFromLastSession() {
            slideInLCDDisplay()
        } else {
            fadeInLCDDisplay()
        }
        refreshLCDDisplay()
        playLogoAnimator()
    }

    private func prepareForWelcomeIntro() {
        lcdDisplay.alpha = 0
    }

    // MARK: - Navigation

    private func presentLogScreen() {
        let storyboard = UIStoryboard(name: UIStoryboard.keys.mainStoryboard, bundle: nil)
        guard let logViewController: LogViewController = storyboard.instantiateViewController(withIdentifier: UIStoryboard.keys.logViewController) as? LogViewController else { return }

        logViewController.datasource = calculatorEngine.history

        let navigationController = UINavigationController(rootViewController: logViewController)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.backgroundColor = UIColor(hex: ThemeManager.shared.currentTheme.background)
        navigationController.navigationBar.tintColor = UIColor(hex: ThemeManager.shared.currentTheme.display)
        present(navigationController, animated: true, completion: nil)
    }

    // MARK: - Notifications

    private func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceivePasteNotification(notification:)), name: Notification.Name(LCDDisplay.keys.pasteNumberNotification), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveHistoryNotification(notification:)), name: Notification.Name(LCDDisplay.keys.historyLogNotification), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(didReceivePasteMathEquationNotification(notification:)), name: Notification.Name(LCDDisplay.keys.pasteEquationNotification), object: nil)
    }

    @objc private func didReceiveHistoryNotification(notification _: Notification) {
        presentLogScreen()
    }

    @objc private func didReceivePasteNotification(notification: Notification) {
        guard let decimalValue = notification.userInfo?[LCDDisplay.keys.userInfo] as? Double else { return }
        pasteNumberIntoCalculator(from: Decimal(decimalValue))
    }

    @objc private func didReceivePasteMathEquationNotification(notification: Notification) {
        guard let mathEquation = notification.userInfo?[LCDDisplay.keys.userInfo] as? Equation else { return }
        pasteNumberIntoCalculator(from: mathEquation)
    }

    // MARK: - Copy & Paste

    private func pasteNumberIntoCalculator(from decimal: Decimal) {
        calculatorEngine.pasteInNumber(from: decimal)
        refreshLCDDisplay()
    }

    private func pasteNumberIntoCalculator(from mathEquation: EquationRepresentable) {
        calculatorEngine.pasteInNumber(from: mathEquation)
        refreshLCDDisplay()
    }
}

class LogoAnimator {
    private weak var logo: UIImageView?

    private var fadeOutTimer: Timer?

    func prepareForAnimation(_ logo: UIImageView?) {
        self.logo = logo
        applyStartAttributes()
    }

    private func applyStartAttributes() {
        logo?.tintColor = UIColor(hex: ThemeManager.shared.currentTheme.operatorNormal)
        logo?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }

    func beginAnimation(_ delay: TimeInterval = 0.5) {
        UIView.animate(withDuration: 1, delay: delay, usingSpringWithDamping: 0.4, initialSpringVelocity: 60, options: .curveEaseInOut) { [weak self] in
            self?.logo?.transform = .identity
            self?.logo?.alpha = 1
        } completion: { _ in
        }
        createStartTimer()
    }

    private func createStartTimer() {
        fadeOutTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(Self.timerFired(_:)), userInfo: nil, repeats: false)
    }

    @objc private func timerFired(_: Timer) {
        fadeOutTimer = nil

        UIView.animate(withDuration: 0.15, delay: 0, options: UIView.AnimationOptions.curveEaseIn) { [weak self] in
            self?.logo?.alpha = 0
            self?.logo?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { _ in
        }
    }
}
