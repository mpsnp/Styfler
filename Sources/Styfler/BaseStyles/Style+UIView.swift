//
//  Style+UIView.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIView styles
extension UIView: Stylable {}

public extension Style where Stylable: UIView {

    static func clipsToBounds(_ clipsToBounds: Bool = true) -> Style {
        return .set(\.clipsToBounds, to: clipsToBounds)
    }

    static func isOpaque(_ isOpaque: Bool = true) -> Style {
        return .set(\.isOpaque, to: isOpaque)
    }

    static func backgroundColor(_ backgroundColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return .set(\.backgroundColor, from: \.colors >>> backgroundColor)
    }

    static func alpha(_ alpha: CGFloat) -> Style {
        return .set(\.alpha, to: alpha)
    }

    static func tintColor(_ tintColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return .set(\.tintColor, from: \.colors >>> tintColor)
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
