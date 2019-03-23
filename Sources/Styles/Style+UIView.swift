//
//  Style+UIView.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation
import UIKit

extension UIView: Stylable {}

// MARK: - UIView styles
public extension Style where Stylable: UIView {

    static func clipsToBounds(_ clipsToBounds: Bool = true) -> Style {
        return Style(set: \.clipsToBounds, to: clipsToBounds)
    }

    static func isOpaque(_ isOpaque: Bool = true) -> Style {
        return Style(set: \.isOpaque, to: isOpaque)
    }

    static func backgroundColor(_ backgroundColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.backgroundColor, from: \.colors >>> backgroundColor)
    }

    static func alpha(_ alpha: CGFloat) -> Style {
        return Style(set: \.alpha, to: alpha)
    }

    static func tintColor(_ tintColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, from: \.colors >>> tintColor)
    }

}

// MARK: - Proxied layer styles
public extension Style where Stylable: UIView {
    static func cornerRadius(_ cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return \.layer <<< .cornerRadius(cornerRadius)
    }

    static func masksToBounds(_ masksToBounds: Bool) -> Style {
        return \.layer <<< .masksToBounds(masksToBounds)
    }

    static func border(width: KeyPath<Theme, CGFloat>, color: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .border(width: width, color: color)
    }

    static func shadow<S: ShadowStyle>(style: KeyPath<ShadowStyles, S>) -> Style {
        return \.layer <<< .shadow(style: style)
    }

    static func gradient<G: GradientStyle>(style: KeyPath<GradientStyles, G>) -> Style where G.BaseTheme == Theme {
        return \.layer <<< .gradient(style: style)
    }
}

// MARK: - Deprecations
public extension Style where Stylable: UIView {
    @available(*, deprecated, renamed: "cornerRadius(_:)")
    static func layer(cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return \.layer <<< .layer(cornerRadius: cornerRadius)
    }

    @available(*, deprecated, renamed: "masksToBounds(_:)")
    static func layer(masksToBounds: Bool) -> Style {
        return \.layer <<< .layer(masksToBounds: masksToBounds)
    }

    @available(*, deprecated, renamed: "border(withWidth:andColor:)")
    static func layer(borderWidth: CGFloat = 1, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .layer(borderWidth: borderWidth, borderColor: borderColor)
    }

    @available(*, deprecated, renamed: "border(withWidth:andColor:)")
    static func layer(borderWidth: KeyPath<Theme, CGFloat>, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .layer(borderWidth: borderWidth, borderColor: borderColor)
    }

    @available(*, deprecated, renamed: "clipsToBounds(_:)")
    static func view(clipsToBounds: Bool = true) -> Style {
        return Style(set: \.clipsToBounds, to: clipsToBounds)
    }

    @available(*, deprecated, renamed: "isOpaque(_:)")
    static func view(isOpaque: Bool = true) -> Style {
        return Style(set: \.isOpaque, to: isOpaque)
    }

    @available(*, deprecated, renamed: "alpha(_:)")
    static func view(alpha: CGFloat) -> Style {
        return Style(set: \.alpha, to: alpha)
    }

    @available(*, deprecated, renamed: "backgroundColor(_:)")
    static func view(backgroundColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.backgroundColor, from: \.colors >>> backgroundColor)
    }

    @available(*, deprecated, renamed: "tintColor(_:)")
    static func view(tintColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, from: \.colors >>> tintColor)
    }

}
