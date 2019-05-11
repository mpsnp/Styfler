//
//  Style+UITabBar.swift
//  Styfler
//
//  Created by George Kiriy on 24/03/2019.
//

import Foundation

extension Style where Stylable: UITabBar {
    static func barStyle(_ style: UIBarStyle) -> Style {
        return .set(\.barStyle, to: style)
    }

    static func barTintColor(_ tintColor: KeyPath<Colors, UIColor>) -> Style {
        return .set(\.barTintColor, from: \.colors >>> tintColor)
    }

    static func isTranslucent(_ isTranslucent: Bool) -> Style {
        return .set(\.isTranslucent, to: isTranslucent)
    }

    static func unselectedItemTintColor(_ tintColor: KeyPath<Colors, UIColor>) -> Style {
        return .set(\.unselectedItemTintColor, from: \.colors >>> tintColor)
    }

    static func backgroundImage(_ image: ImageProvider?) -> Style {
        return .set(\.backgroundImage, to: image?.image)
    }

    static func shadowImage(_ image: ImageProvider?) -> Style {
        return .set(\.shadowImage, to: image?.image)
    }

    static func selectionIndicatorImage(_ image: ImageProvider?) -> Style {
        return .set(\.selectionIndicatorImage, to: image?.image)
    }

    static func itemPositioning(_ positioning: UITabBar.ItemPositioning) -> Style {
        return .set(\.itemPositioning, to: positioning)
    }

    static func itemSpacing(_ spacing: CGFloat) -> Style {
        return .set(\.itemSpacing, to: spacing)
    }

    static func itemWidth(_ width: CGFloat) -> Style {
        return .set(\.itemWidth, to: width)
    }
}
