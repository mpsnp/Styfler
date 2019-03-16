//
//  Style+UIButton.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

public extension Style where Stylable: UIButton {
    static func button(title: String, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setTitle(title, for: state)
        }
    }

    static func button(titleColor: KeyPath<Colors, UIColor>, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setTitleColor(theme[keyPath: \.colors >>> titleColor], for: state)
        }
    }

    static func button(titleStyle: KeyPath<TextStyles, TextStyle>) -> Style {
        return Style(set: \.titleLabel!.font, from: \.textStyles >>> titleStyle >>> \.font)
    }

    static func button(image: ImageProvider, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setImage(image.image, for: state)
        }
    }
}
