//
//  ThemeManager.swift
//  Rocket.Chat
//
//  Created by Samar Sunkaria on 4/27/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import Foundation
import SlackTextViewController

struct ThemeManager {
    static var theme = Theme.dark {
        didSet {
            UIView.animate(withDuration: 0.3) {
                observers.forEach { $0?.applyTheme(theme) }
            }
        }
    }

    static var observers = [Themeable?]()
    static func addObserver(_ observer: Themeable?) {
        observers = observers.compactMap { $0 }
        guard let observer = observer else { return }
        observer.applyTheme(ThemeManager.theme)
        weak var weakObserver = observer
        observers.append(weakObserver)
    }
}

@objc protocol Themeable {
    func applyTheme(_ theme: Theme)
    var theme: Theme? { get }
}

extension UIView: Themeable {
    func applyTheme(_ theme: Theme) {
        backgroundColor = theme.backgroundColor.withAlphaComponent(backgroundColor?.cgColor.alpha ?? 0.0)
        self.subviews.forEach { $0.applyTheme(theme) }
    }

    var theme: Theme? { return superview?.theme }
}

extension UILabel {
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        textColor = theme.bodyText
    }
}

extension UISearchBar {
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        barStyle = theme.appearence.barStyle
        tintColor = theme.hyperlinkText
        keyboardAppearance = .light
    }
}

extension UICollectionView {
    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        if let theme = theme {
            view.applyTheme(theme)
        }
    }

    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        if let theme = theme {
            view.applyTheme(theme)
        }
    }
}

extension SLKTextView {
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        self.textColor = theme.bodyText
        self.layer.borderColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.1518210827)
        self.backgroundColor = #colorLiteral(red: 0.497693181, green: 0.494099319, blue: 0.5004472733, alpha: 0.04910321301)
    }
}

extension UITextView {
    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        self.tintColor = theme.hyperlinkText
    }
}

extension UINavigationBar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        self.subviews.forEach { $0.applyTheme(theme) }
        self.barTintColor = theme.focusedBackground
        self.tintColor = theme.bodyText
        self.barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        if let theme = theme {
            view.applyTheme(theme)
        }
    }
}

extension UIToolbar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        self.isTranslucent = false
        self.barTintColor = theme.focusedBackground
        self.tintColor = theme.tintColor
        self.barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        if let theme = theme {
            view.applyTheme(theme)
        }
    }
}

extension UITabBar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        self.barTintColor = theme.focusedBackground
        self.tintColor = theme.tintColor
        self.barStyle = theme.appearence.barStyle
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        if let theme = theme {
            view.applyTheme(theme)
        }
    }
}

extension SLKTextInputbar {
    override var theme: Theme? { return ThemeManager.theme }

    override func applyTheme(_ theme: Theme) {
        super.applyTheme(theme)
        textView.keyboardAppearance = theme.appearence.keyboardAppearence
    }

    open override func insertSubview(_ view: UIView, at index: Int) {
        super.insertSubview(view, at: index)
        if let theme = theme {
            view.applyTheme(theme)
        }
    }
}