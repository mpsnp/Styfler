//
//  Styler.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation
import UIKit

extension UIView.AnimationCurve {
    var timingFunctionName: CAMediaTimingFunctionName {
        switch self {
        case .easeIn:
            return .easeIn
        case .easeInOut:
            return .easeInEaseOut
        case .easeOut:
            return .easeOut
        case .linear:
            return .linear
        @unknown default:
            return .default
        }
    }

    var animationOptions: UIView.AnimationOptions {
        switch self {
        case .easeInOut:
            return .curveEaseInOut
        case .easeIn:
            return .curveEaseIn
        case .easeOut:
            return .curveEaseOut
        case .linear:
            return .curveLinear
        @unknown default:
            return .curveEaseInOut
        }
    }
}

public final class Styler<Stylable: Styfler.Stylable, Theme: Styfler.Theme> {
    let instance: Stylable
    let theme: Theme
    let options: StylingOptions
    var animator: UIViewPropertyAnimator?

    init(instance: Stylable, theme: Theme, options: StylingOptions) {
        self.instance = instance
        self.theme = theme
        self.options = options
    }

    public func apply(style: Style<Stylable, Theme>) {
        switch self.options.animation {
        case let .animated(duration, curve):
            CATransaction.begin()

            CATransaction.setAnimationDuration(duration)
            CATransaction.setAnimationTimingFunction(.init(name: curve.timingFunctionName))

            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: duration,
                delay: 0,
                options: curve.animationOptions,
                animations: {
                    style.apply(to: self.instance, with: self.theme, options: self.options)
                }
            )

            CATransaction.commit()
        case .none:
            style.apply(to: self.instance, with: self.theme, options: self.options)
        }
    }
}

public func <| <S, T> (styler: Styler<S, T>, style: Style<S, T>) {
    styler.apply(style: style)
}
