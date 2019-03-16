//
//  Styler.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation

extension CAMediaTimingFunctionName {
    var curve: UIView.AnimationCurve {
        switch self {
        case CAMediaTimingFunctionName.default:
            return .easeInOut
        case CAMediaTimingFunctionName.easeIn:
            return .easeIn
        case CAMediaTimingFunctionName.easeOut:
            return .easeOut
        case CAMediaTimingFunctionName.easeInEaseOut:
            return .easeInOut
        case CAMediaTimingFunctionName.linear:
            return .linear
        default:
            return .easeInOut
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
        switch options.animation {
        case let .animated(duration, timing):
            animator = .init(duration: duration, curve: timing.curve) {
                style.apply(to: self.instance, with: self.theme, options: self.options)
            }
            animator?.addCompletion { _ in
                self.animator = nil
            }
            animator?.startAnimation()
        case .none:
            style.apply(to: instance, with: theme, options: options)
        }
    }

    public static func <| (styler: Styler, style: Style<Stylable, Theme>) {
        styler.apply(style: style)
    }
}
