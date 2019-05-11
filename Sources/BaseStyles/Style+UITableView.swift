//
//  Style+UITableView.swift
//  Styfler
//
//  Created by George Kiriy on 24/03/2019.
//

import Foundation

extension Style where Stylable: UITableView {
    static func rowHeight(_ rowHeight: CGFloat) -> Style {
        return .set(\.rowHeight, to: rowHeight)
    }

    static func separator(style: UITableViewCell.SeparatorStyle) -> Style {
        return .set(\.separatorStyle, to: style)
    }

    static func separator(color: KeyPath<Colors, UIColor>) -> Style {
        return .set(\.separatorColor, from: \.colors >>> color)
    }

    static func separator(effect: UIVisualEffect) -> Style {
        return .set(\.separatorEffect, to: effect)
    }

    static func separator(inset: UIEdgeInsets) -> Style {
        return .set(\.separatorInset, to: inset)
    }

    @available(iOS 11.0, *)
    static func separator(insetReference: UITableView.SeparatorInsetReference) -> Style {
        return .set(\.separatorInsetReference, to: insetReference)
    }

    static func cellLayoutMarginsFollowReadableWidth(_ cellLayoutMarginsFollowReadableWidth: Bool) -> Style {
        return .set(\.cellLayoutMarginsFollowReadableWidth, to: cellLayoutMarginsFollowReadableWidth)
    }
}
