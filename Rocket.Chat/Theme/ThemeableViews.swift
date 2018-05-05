//
//  ThemeableViews.swift
//  Rocket.Chat
//
//  Created by Samar Sunkaria on 5/2/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import UIKit
import SlackTextViewController

extension UIView: Themeable, ThemeProvider {
    func applyTheme() {
        guard let theme = theme else { return }
        backgroundColor = theme.backgroundColor.withAlphaComponent(backgroundColor?.cgColor.alpha ?? 0.0)
        self.subviews.forEach { $0.applyTheme() }
    }

    var theme: Theme? {
        guard let superview = superview else { return ThemeManager.theme }
        return superview.theme
    }
}

extension UILabel {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        textColor = theme.titleText
    }
}

extension UITextField {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        textColor = theme.titleText
        keyboardAppearance = theme.appearence.keyboardAppearence
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: theme.mutedAccent])
        }
    }
}

extension UISearchBar {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        barStyle = theme.appearence.barStyle
        tintColor = theme.hyperlinkText
        keyboardAppearance = theme.appearence.keyboardAppearence
        let textField = subviews.first?.subviews.first { $0 is UITextField } as? UITextField
        textField?.backgroundColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.04910321301)
    }
}

extension UIActivityIndicatorView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        color = theme.bodyText
    }
}

extension UIRefreshControl {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        tintColor = theme.bodyText
    }
}

extension UICollectionView {
    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }

    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.applyTheme()
    }
}

extension UITableView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        switch theme {
        case .dark, .black: backgroundColor = style == .grouped ? theme.focusedBackground : theme.backgroundColor
        default: backgroundColor = style == .grouped ? #colorLiteral(red: 0.937, green: 0.937, blue: 0.957, alpha: 1) : theme.backgroundColor
        }
        separatorColor = theme.mutedAccent
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }

    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.applyTheme()
    }
}

extension UITableViewCell {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        detailTextLabel?.textColor = theme.auxiliaryText
    }
}

extension SLKTextView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        self.textColor = theme.bodyText
        self.layer.borderColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.1518210827)
        self.backgroundColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.04910321301)
    }
}

extension UITextView {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        self.tintColor = theme.hyperlinkText
    }
}

extension UINavigationBar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        self.subviews.forEach { $0.applyTheme() }
        self.tintColor = theme.bodyText
        self.barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        applyTheme()
    }
}

extension UIToolbar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        self.isTranslucent = false
        self.barTintColor = theme.focusedBackground
        self.tintColor = theme.tintColor
        self.barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }
}

extension UITabBar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        self.barTintColor = theme.focusedBackground
        self.tintColor = theme.tintColor
        self.barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }
}

extension SLKTextInputbar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        textView.keyboardAppearance = theme.appearence.keyboardAppearence
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        view.applyTheme()
    }
}