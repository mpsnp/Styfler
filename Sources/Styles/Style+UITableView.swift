//
//  Style+UITableView.swift
//  Styfler
//
//  Created by George Kiriy on 24/03/2019.
//

import Foundation

extension Style where Stylable: UITableView {
    static func rowHeight(_ rowHeight: CGFloat) -> Style {
        return Style(set: \.rowHeight, to: rowHeight)
    }

    static func separator(style: UITableViewCell.SeparatorStyle) -> Style {
        return Style(set: \.separatorStyle, to: style)
    }

    static func separator(color: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.separatorColor, from: \.colors >>> color)
    }

    static func separator(effect: UIVisualEffect) -> Style {
        return Style(set: \.separatorEffect, to: effect)
    }

    static func separator(inset: UIEdgeInsets) -> Style {
        return Style(set: \.separatorInset, to: inset)
    }

    @available(iOS 11.0, *)
    static func separator(insetReference: UITableView.SeparatorInsetReference) -> Style {
        return Style(set: \.separatorInsetReference, to: insetReference)
    }

    static func cellLayoutMarginsFollowReadableWidth(_ cellLayoutMarginsFollowReadableWidth: Bool) -> Style {
        return Style(set: \.cellLayoutMarginsFollowReadableWidth, to: cellLayoutMarginsFollowReadableWidth)
    }
}
