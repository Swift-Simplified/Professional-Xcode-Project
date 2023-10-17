//
//  LogViewController.swift
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
//   It's a screen. It displays a list of all of the executed equations
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import UIKit

class LogViewController: UITableViewController {
    // MARK: - Datasource

    var datasource: [EquationRepresentable] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        decorateViewWithTheme(ThemeManager.shared.currentTheme)
    }

    // MARK: - Navigation Bar

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
    }

    @objc private func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - TableView

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MathEquationTableViewCell", for: indexPath) as? EquationCell else {
            return UITableViewCell()
        }

        let theme = ThemeManager.shared.currentTheme
        decorateTableViewCell(cell, withTheme: theme, from: indexPath)

        guard let mathEquation = datasource[safe: indexPath.row] else {
            return UITableViewCell()
        }

        populateTableViewCellFromEquation(mathEquation, cell: cell)
        return cell
    }

    private func populateTableViewCellFromEquation(_ mathEquation: EquationRepresentable, cell: EquationCell) {
        cell.lhsLabel.text = mathEquation.lhs.formatted()
        cell.rhsLabel.text = mathEquation.operation?.symbol ?? "" + " " + (mathEquation.rhs?.formatted() ?? "")
        cell.resultLabel.text = "= " + (mathEquation.result?.formatted() ?? "")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? EquationCell,
            let mathEquation = datasource[safe: indexPath.row]
        else { return }

        let userInfo: [AnyHashable: Any] = [LCDDisplay.keys.userInfo: mathEquation]
        NotificationCenter.default.post(name: Notification.Name(LCDDisplay.keys.pasteEquationNotification), object: nil, userInfo: userInfo)

        view.isUserInteractionEnabled = false
        cell.displayTick()
        dismissAfterDelay()
    }

    private func dismissAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Decorate

    private func decorateViewWithTheme(_ theme: CalculatorTheme) {
        tableView.backgroundColor = UIColor(hex: theme.background)
        tableView.separatorColor = UIColor(hex: theme.display)
        tableView.tintColor = UIColor(hex: theme.display)
        switch theme.statusBarStyle {
        case .light:
            tableView.indicatorStyle = .white
        case .dark:
            tableView.indicatorStyle = .black
        }
    }

    private func decorateTableViewCell(_ cell: EquationCell, withTheme theme: CalculatorTheme, from _: IndexPath) {
        cell.backgroundColor = UIColor(hex: theme.background)
        cell.selectedBackgroundView?.backgroundColor = UIColor(hex: theme.operatorNormal)
        cell.lhsLabel.textColor = UIColor(hex: theme.display)
        cell.lhsLabel.highlightedTextColor = UIColor(hex: theme.background)
        cell.rhsLabel.textColor = UIColor(hex: theme.display)
        cell.rhsLabel.highlightedTextColor = UIColor(hex: theme.background)
        cell.resultLabel.textColor = UIColor(hex: theme.display)
        cell.resultLabel.highlightedTextColor = UIColor(hex: theme.background)

        cell.tick.tintColor = UIColor(hex: theme.operatorTitle)
    }
}
