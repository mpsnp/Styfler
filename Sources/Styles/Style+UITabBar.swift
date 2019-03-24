//
//  Style+UITabBar.swift
//  Styfler
//
//  Created by George Kiriy on 24/03/2019.
//

import Foundation

extension Style where Stylable: UITabBar {
    static func bar(style: UIBarStyle) -> Style {
        return Style(set: \.barStyle, to: style)
    }

    static func bar(tintColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.barTintColor, from: \.colors >>> tintColor)
    }

    static func isTranslucent(_ isTranslucent: Bool) -> Style {
        return Style(set: \.isTranslucent, to: isTranslucent)
    }

    static func unselectedItem(tintColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.unselectedItemTintColor, from: \.colors >>> tintColor)
    }

    static func background(image: ImageProvider?) -> Style {
        return Style(set: \.backgroundImage, to: image?.image)
    }

    static func shadow(image: ImageProvider?) -> Style {
        return Style(set: \.shadowImage, to: image?.image)
    }

    static func selectionIndicator(image: ImageProvider?) -> Style {
        return Style(set: \.selectionIndicatorImage, to: image?.image)
    }

    static func item(positioning: UITabBar.ItemPositioning) -> Style {
        return Style(set: \.itemPositioning, to: positioning)
    }

    static func item(spacing: CGFloat) -> Style {
        return Style(set: \.itemSpacing, to: spacing)
    }

    static func item(width: CGFloat) -> Style {
        return Style(set: \.itemWidth, to: width)
    }
}
