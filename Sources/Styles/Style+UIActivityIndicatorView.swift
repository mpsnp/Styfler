//
//  Style+UIActivityIndicatorView.swift
//  Pods-StyflerExample
//
//  Created by Valeriy Mikholapov on 24/03/2019.
//

public extension Style where Stylable: UIActivityIndicatorView {

    static func hidesWhenStopped(_ hidesWhenStopped: Bool) -> Style {
        return .init(set: \.hidesWhenStopped, to: hidesWhenStopped)
    }

    static func style(_ style: UIActivityIndicatorView.Style) -> Style {
        return .init(set: \.style, to: style)
    }

    static func color(_ color: KeyPath<Colors, UIColor>) -> Style {
        return .init(set: \.color, from: \.colors >>> color)
    }

}
