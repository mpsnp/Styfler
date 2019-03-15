//
//  Style+UILabel.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

public extension Style where Stylable: UILabel {
    static func text(color: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.textColor, fromTheme: \.colors >>> color)
    }

    static func text(highlightedColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.highlightedTextColor, fromTheme: \.colors >>> highlightedColor)
    }

    static func text(font: KeyPath<TextStyles, UIFont>) -> Style {
        return Style(set: \.font, fromTheme: \.textStyles >>> font)
    }

    static func text(alignment: NSTextAlignment = .natural) -> Style {
        return Style(set: \.textAlignment, to: alignment)
    }

    static func text<S: TextStyle>(
        style: KeyPath<TextStyles, S>,
        color: KeyPath<Colors, UIColor>,
        alignment: NSTextAlignment = .natural
    ) -> Style {
        return .text(color: color)
            <> .text(font: style >>> \.font)
            <> .text(alignment: alignment)
    }

    static func text(normal: String) -> Style {
        return Style(set: \.text, to: normal)
    }

    static func text(attributed: NSAttributedString) -> Style {
        return Style(set: \.attributedText, to: attributed)
    }
}
