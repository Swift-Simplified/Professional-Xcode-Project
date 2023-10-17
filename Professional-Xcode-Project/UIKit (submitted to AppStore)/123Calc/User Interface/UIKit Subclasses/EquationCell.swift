//
//  EquationCell.swift
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
//   It's a subclass. This is the cell for each equation displayed in the history log.
//   Architectural Layer: The user interface (UI) of the app.
//
// -------------------------------------------------------------------------------------------

import UIKit

class EquationCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet var lhsLabel: UILabel! // → 💡 Tip: Unwrapping Optionals - If this label is not connected then the app will crash!
    @IBOutlet var rhsLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var tick: UIImageView!

    // MARK: - Initialise

    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView()
        tick.alpha = 0
    }

    // MARK: - Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Animation

    func displayTick() {
        bounce(tick)
    }

    private func bounce(_ view: UIView) {
        UIView.animate(withDuration: 0.25,
                       animations: { [weak view] in
                           view?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                           view?.alpha = 1
                       },
                       completion: { _ in
                           UIView.animate(withDuration: 0.1) { [weak view] in
                               view?.transform = CGAffineTransform.identity
                           }
                       })
    }
}
