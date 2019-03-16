//
//  Style+UILabel.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

public extension Style where Stylable: UILabel {
    static func label(textColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.textColor, from: \.colors >>> textColor)
    }

    static func label(highlightedTextColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.highlightedTextColor, from: \.colors >>> highlightedTextColor)
    }

    static func label(font: KeyPath<TextStyles, UIFont>) -> Style {
        return Style(set: \.font, from: \.textStyles >>> font)
    }

    static func label(textAlignment: NSTextAlignment = .natural) -> Style {
        return Style(set: \.textAlignment, to: textAlignment)
    }

    static func label<S: TextStyle>(
        style: KeyPath<TextStyles, S>,
        textColor: KeyPath<Colors, UIColor>,
        textAlignment: NSTextAlignment = .natural
    ) -> Style {
        return .label(textColor: textColor)
            <> .label(font: style >>> \.font)
            <> .label(textAlignment: textAlignment)
    }

    static func label(text: String) -> Style {
        return Style(set: \.text, to: text)
    }

    static func label(attributedText: NSAttributedString) -> Style {
        return Style(set: \.attributedText, to: attributedText)
    }
}
