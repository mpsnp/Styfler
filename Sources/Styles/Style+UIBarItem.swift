//
//  Style+UIBarItem.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 23/03/2019.
//

import Foundation

extension UIBarItem: Stylable {}

public extension Style where Stylable: UIBarItem {
    static func title(_ title: String) -> Style {
        return Style(set: \.title, to: title)
    }

    static func titleTextAttributes(
        for state: UIControl.State = .normal,
        extract: @escaping (Theme) -> [NSAttributedString.Key: Any]?
    ) -> Style {
        return .init { item, theme, options in
            item.setTitleTextAttributes(extract(theme), for: state)
        }
    }

    static func image(_ image: ImageProvider, insets: UIEdgeInsets = .zero) -> Style {
        return Style(set: \.image, to: image.image)
            <> Style(set: \.imageInsets, to: insets)
    }

    static func landscapePhoneImage(_ image: ImageProvider, insets: UIEdgeInsets = .zero) -> Style {
        return Style(set: \.landscapeImagePhone, to: image.image)
            <> Style(set: \.landscapeImagePhoneInsets, to: insets)
    }

    @available(iOS 11.0, *)
    static func largeContentSizeImage(_ image: ImageProvider, insets: UIEdgeInsets = .zero) -> Style {
        return Style(set: \.largeContentSizeImage, to: image.image)
            <> Style(set: \.largeContentSizeImageInsets, to: insets)
    }
}

public extension Style where Stylable: UIBarButtonItem {
    static func style(_ style: UIBarButtonItem.Style) -> Style {
        return Style(set: \.style, to: style)
    }

    static func width(_ width: CGFloat) -> Style {
        return Style(set: \.width, to: width)
    }

    static func tintColor(_ tintColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, from: \.colors >>> tintColor)
    }
}

public extension Style where Stylable: UITabBarItem {
    static func selectedImage(_ selectedImage: ImageProvider) -> Style {
        return Style(set: \.selectedImage, to: selectedImage.image)
    }

    static func badge(value: String?) -> Style {
        return Style(set: \.badgeValue, to: value)
    }

    static func badge(color: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.badgeColor, from: \.colors >>> color)
    }

    static func badgeTextAttributes(
        for state: UIControl.State = .normal,
        extract: @escaping (Theme) -> [NSAttributedString.Key: Any]?
    ) -> Style {
        return .init { item, theme, options in
            item.setBadgeTextAttributes(extract(theme), for: state)
        }
    }
}
