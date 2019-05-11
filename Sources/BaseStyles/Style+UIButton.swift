//
//  Style+UIButton.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

// MARK: - UIButton styles
public extension Style where Stylable: UIButton {
    
    static func title(_ title: String, state: UIControl.State = .normal) -> Style {
        return .custom { button, theme, options in
            button.setTitle(title, for: state)
        }
    }

    static func titleColor(_ titleColor: KeyPath<Colors, UIColor>, state: UIControl.State = .normal) -> Style {
        return .custom { button, theme, options in
            button.setTitleColor(theme[keyPath: \.colors >>> titleColor], for: state)
        }
    }

    static func titleStyle(_ titleStyle: KeyPath<TextStyles, TextStyle>) -> Style {
        return .set(\.titleLabel!.font, from: \.textStyles >>> titleStyle >>> \.font)
    }

    static func image(_ image: ImageProvider, state: UIControl.State = .normal) -> Style {
        return .custom { button, theme, options in
            button.setImage(image.image, for: state)
        }
    }
}
