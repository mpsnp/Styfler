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
    static func background(color: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.backgroundColor, fromTheme: \.colors >>> color)
    }

    static func tint(color: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, fromTheme: \.colors >>> color)
    }
}

// MARK: - Layer wrappers
public extension Style where Stylable: UIView {
    static func layer(cornerRadius: KeyPath<Theme.CornerRadiuses, CGFloat>, animated: Bool = true) -> Style {
        return \.layer <<< .init(set: \.cornerRadius, from: \.cornerRadiuses >>> cornerRadius, animated: animated)
    }

    static func layer(masksToBounds: Bool, animated: Bool = true) -> Style {
        return \.layer <<< .init(set: \.masksToBounds, to: masksToBounds, animated: animated)
    }

    static func border(width: CGFloat = 1, color: KeyPath<Theme.Colors, UIColor>, animated: Bool = true) -> Style {
        return \.layer <<< .init(set: \.borderWidth, to: width, animated: animated)
            <> \.layer <<< .init(set: \.borderColor, fromTheme: \.colors >>> color >>> \.cgColor)
    }
}
