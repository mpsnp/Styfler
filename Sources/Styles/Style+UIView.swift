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

public extension Style where Stylable: UIView {
    static func view(clipsToBounds: Bool = true) -> Style {
        return Style(set: \.clipsToBounds, to: clipsToBounds)
    }

    static func view(isOpaque: Bool = true) -> Style {
        return Style(set: \.isOpaque, to: isOpaque)
    }

    static func view(alpha: CGFloat) -> Style {
        return Style(set: \.alpha, to: alpha)
    }

    static func view(backgroundColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.backgroundColor, from: \.colors >>> backgroundColor)
    }

    static func view(tintColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, from: \.colors >>> tintColor)
    }
}

// MARK: - Layer wrappers
public extension Style where Stylable: UIView {
    static func layer(cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return \.layer <<< .init(set: \.cornerRadius, from: \.cornerRadiuses >>> cornerRadius)
    }

    static func layer(masksToBounds: Bool) -> Style {
        return \.layer <<< .init(set: \.masksToBounds, to: masksToBounds)
    }

    static func layer(borderWidth: CGFloat = 1, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .init(set: \.borderWidth, to: borderWidth)
            <> \.layer <<< .init(set: \.borderColor, from: \.colors >>> borderColor >>> \.cgColor)
    }

    static func layer(borderWidth: KeyPath<Theme, CGFloat>, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .init(set: \.borderWidth, from: borderWidth)
            <> \.layer <<< .init(set: \.borderColor, from: \.colors >>> borderColor >>> \.cgColor)
    }
}
