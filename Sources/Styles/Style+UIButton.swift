//
//  Style+UIButton.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

public extension Style where Stylable: UIButton {
    static func title(text: String, state: UIControl.State = .normal) -> Style {
        return .init { button, theme in
            button.setTitle(text, for: state)
        }
    }

    static func title(color: KeyPath<Colors, UIColor>, state: UIControl.State = .normal) -> Style {
        return .init { button, theme in
            button.setTitleColor(theme[keyPath: \.colors >>> color], for: state)
        }
    }

    //    static func title(style: KeyPath<TextStyles, TextStyles.Style>) -> Style {
    //        return Style(set: \.titleLabel!.font, from: \.textStyles >>> style >>> \.font)
    //    }

    static func image(_ provider: ImageProvider, state: UIControl.State = .normal) -> Style {
        return .init { button, theme in
            button.setImage(provider.image, for: state)
        }
    }
}
