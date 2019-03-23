//
//  Style+UILabel.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

// MARK: - UILabel styles
public extension Style where Stylable: UILabel {

    static func text(_ text: String) -> Style {
        return Style(set: \.text, to: text)
    }

    static func attributedText(_ attributedText: NSAttributedString) -> Style {
        return Style(set: \.attributedText, to: attributedText)
    }

    static func textColor(_ textColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.textColor, from: \.colors >>> textColor)
    }

    static func highlightedTextColor(_ highlightedTextColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.highlightedTextColor, from: \.colors >>> highlightedTextColor)
    }

    static func textAlignment(_ textAlignment: NSTextAlignment = .natural) -> Style {
        return Style(set: \.textAlignment, to: textAlignment)
    }

    static func font(_ font: KeyPath<TextStyles, UIFont>) -> Style {
        return Style(set: \.font, from: \.textStyles >>> font)
    }

    static func style<S: TextStyle>(
        _ style: KeyPath<TextStyles, S>,
        textColor: KeyPath<Colors, UIColor>,
        textAlignment: NSTextAlignment = .natural
    ) -> Style {
        return .textColor(textColor)
            <> .font(style >>> \.font)
            <> .textAlignment(textAlignment)
    }
}

// MARK: - Deprecations
public extension Style where Stylable: UILabel {
    @available(*, deprecated, renamed: "textColor(_:)")
    static func label(textColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.textColor, from: \.colors >>> textColor)
    }

    @available(*, deprecated, renamed: "highlightedTextColor(_:)")
    static func label(highlightedTextColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.highlightedTextColor, from: \.colors >>> highlightedTextColor)
    }

    @available(*, deprecated, renamed: "font(_:)")
    static func label(font: KeyPath<TextStyles, UIFont>) -> Style {
        return Style(set: \.font, from: \.textStyles >>> font)
    }

    @available(*, deprecated, renamed: "textAlignment(_:)")
    static func label(textAlignment: NSTextAlignment = .natural) -> Style {
        return Style(set: \.textAlignment, to: textAlignment)
    }

    @available(*, deprecated, renamed: "style(_:textColor:textAlignment:)")
    static func label<S: TextStyle>(
        style: KeyPath<TextStyles, S>,
        textColor: KeyPath<Colors, UIColor>,
        textAlignment: NSTextAlignment = .natural
    ) -> Style {
        return .label(textColor: textColor)
            <> .label(font: style >>> \.font)
            <> .label(textAlignment: textAlignment)
    }

    @available(*, deprecated, renamed: "text(_:)")
    static func label(text: String) -> Style {
        return Style(set: \.text, to: text)
    }

    @available(*, deprecated, renamed: "attributedText(_:)")
    static func label(attributedText: NSAttributedString) -> Style {
        return Style(set: \.attributedText, to: attributedText)
    }
}
