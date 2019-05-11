//
//  ViewController.swift
//  StyflerExample
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 mpsnp. All rights reserved.
//

import UIKit
import Styfler

extension Style where Stylable: UIButton, Theme == AppTheme {
    private static func defaultButton() -> Style {
        return .cornerRadius(\.standard)
            <> .border(width: \.borderWidth, color: \.border)
            <> .shadow(style: \.base)
    }

    static func primaryAction() -> Style {
        return .defaultButton()
            <> .titleColor(\.secondary)
            <> .backgroundColor(\.primary)
    }

    static func secondaryAction() -> Style {
        return .defaultButton()
            <> .titleColor(\.buttonText)
            <> .backgroundColor(\.secondary)
    }
}

extension UIViewController: DefaultStylable {
    public typealias Theme = AppTheme
}

extension Style where Stylable == ViewController, Theme == AppTheme {
    static var standard: Style {
        return \.view
                <<< .backgroundColor(\.primary)
            <> \.barButtonItem
                <<< .tintColor(\.secondary)
            <> \.lightButton
                <<< .primaryAction()
            <> \.darkButton
                <<< .secondaryAction()
    }
}

final class ViewController: UIViewController {

    @IBOutlet var barButtonItem: UIBarButtonItem!
    @IBOutlet var lightButton: UIButton!
    @IBOutlet var darkButton: UIButton!

    var theme: AppTheme = .light {
        didSet { apply(theme: theme) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        apply(theme: theme)
    }

    func apply(theme: AppTheme) {
        self.style(with: theme).apply(style: .standard)

        self.setNeedsStatusBarAppearanceUpdate()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme == .light
            ? .default
            : .lightContent
    }

    @IBAction func lightTouched() {
        theme = theme == .light
            ? .dark
            : .light
    }

    @IBAction func darkTouched() {
        theme = .dark
    }
}
