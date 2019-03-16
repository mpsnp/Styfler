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
    static func primaryAction() -> Style {
        return .view(backgroundColor: \.secondary)
            <> .layer(cornerRadius: \.standard)
            <> .title(color: \.buttonText)
    }
}

extension UIViewController: DefaultStylable {
    public typealias Theme = AppTheme
}

extension Style where Stylable == ViewController, Theme == AppTheme {
    static func standard() -> Style {
        return \.view <<< .view(backgroundColor: \.primary)
            <> \.lightButton <<< .primaryAction()
            <> \.darkButton <<< .primaryAction()
    }
}

final class ViewController: UIViewController {
    @IBOutlet var lightButton: UIButton!
    @IBOutlet var darkButton: UIButton!

    let animator: UIViewPropertyAnimator = .init(duration: 0.25, curve: .easeInOut)

    var theme: AppTheme = .light {
        didSet { apply(theme: theme) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        apply(theme: theme)
    }

    func apply(theme: AppTheme) {
        animator.addAnimations {
            self.style(with: theme) <| .standard()

            self.setNeedsStatusBarAppearanceUpdate()
        }
        animator.startAnimation()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return theme == .light
            ? .default
            : .lightContent
    }

    @IBAction func lightTouched() {
        theme = .light
    }

    @IBAction func darkTouched() {
        theme = .dark
    }
}
