//
//  Style+UILabel.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation
import UIKit

// MARK: - UILabel styles
public extension Style where Stylable: UILabel {

    static func text(_ text: String) -> Style {
        return .set(\.text, to: text)
    }

    static func attributedText(_ attributedText: NSAttributedString) -> Style {
        return .set(\.attributedText, to: attributedText)
    }

    static func textColor(_ textColor: KeyPath<Colors, UIColor>) -> Style {
        return .set(\.textColor, from: \.colors >>> textColor)
    }

    static func highlightedTextColor(_ highlightedTextColor: KeyPath<Colors, UIColor>) -> Style {
        return .set(\.highlightedTextColor, from: \.colors >>> highlightedTextColor)
    }

    static func textAlignment(_ textAlignment: NSTextAlignment = .natural) -> Style {
        return .set(\.textAlignment, to: textAlignment)
    }

    static func font(_ font: KeyPath<TextStyles, UIFont>) -> Style {
        return .set(\.font, from: \.textStyles >>> font)
    }
}

public extension Style where Stylable: UILabel {
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
