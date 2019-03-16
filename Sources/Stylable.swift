//
//  Stylable.swift
//  Styfler
//
//  Created by George Kiriy on 15/03/2019.
//

import Foundation

public protocol Stylable: AnyObject {
}

public protocol DefaultStylable: Stylable {
    associatedtype Theme: Styfler.Theme
}

public extension DefaultStylable {
    func style(with theme: Theme, options: StylingOptions = .animateLayers()) -> Styler<Self, Theme> {
        return Styler(instance: self, theme: theme, options: options)
    }

    static var s: Style<Self, Theme>.Type {
        return Style<Self, Theme>.self
    }

    var s: Style<Self, Theme>.Type {
        return Style<Self, Theme>.self
    }
}
