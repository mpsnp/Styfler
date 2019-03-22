//
//  Style+UIButton.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

// MARK: - Deprecated

public extension Style where Stylable: UIButton {
    @available(*, deprecated, renamed: "title(_:state:)")
    static func button(title: String, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setTitle(title, for: state)
        }
    }

    @available(*, deprecated, renamed: "titleColor(_:state:)")
    static func button(titleColor: KeyPath<Colors, UIColor>, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setTitleColor(theme[keyPath: \.colors >>> titleColor], for: state)
        }
    }

    @available(*, deprecated, renamed: "titleStyle(_:)")
    static func button(titleStyle: KeyPath<TextStyles, TextStyle>) -> Style {
        return Style(set: \.titleLabel!.font, from: \.textStyles >>> titleStyle >>> \.font)
    }

    @available(*, deprecated, renamed: "image(_:state:)")
    static func button(image: ImageProvider, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setImage(image.image, for: state)
        }
    }
}

// MARK: -

public extension Style where Stylable: UIButton {

    static func title(_ title: String, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setTitle(title, for: state)
        }
    }

    static func titleColor(_ titleColor: KeyPath<Colors, UIColor>, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setTitleColor(theme[keyPath: \.colors >>> titleColor], for: state)
        }
    }

    static func titleStyle(_ titleStyle: KeyPath<TextStyles, TextStyle>) -> Style {
        return Style(set: \.titleLabel!.font, from: \.textStyles >>> titleStyle >>> \.font)
    }

    static func image(_ image: ImageProvider, state: UIControl.State = .normal) -> Style {
        return .init { button, theme, options in
            button.setImage(image.image, for: state)
        }
    }

}
