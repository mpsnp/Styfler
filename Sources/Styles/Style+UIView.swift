//
//  Style+UIView.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation
import UIKit

public extension Style where Stylable: UIView {
    static func background(color: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.backgroundColor, fromTheme: \.colors >>> color)
    }

    static func layer(cornerRadius: KeyPath<Theme.CornerRadiuses, CGFloat>) -> Style {
        return Style(set: \.layer.cornerRadius, fromTheme: \.cornerRadiuses >>> cornerRadius)
    }

    static func layer(masksToBounds: Bool) -> Style {
        return Style(set: \.layer.masksToBounds, to: masksToBounds)
    }

    static func border(width: CGFloat = 1, color: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.layer.borderWidth, to: width)
            <> Style(set: \.layer.borderColor, fromTheme: \.colors >>> color >>> \.cgColor)
    }

    static func tint(color: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, fromTheme: \.colors >>> color)
    }
}
