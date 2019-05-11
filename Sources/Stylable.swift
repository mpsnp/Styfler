//
//  Stylable.swift
//  Styfler
//
//  Created by George Kiriy on 15/03/2019.
//

import Foundation

public protocol Stylable: AnyObject {
}

public extension Stylable {
    func style<T: Theme>(with theme: T, options: StylingOptions = .animated()) -> Styler<Self, T> {
        return Styler(instance: self, theme: theme, options: options)
    }
}

public protocol DefaultStylable: Stylable {
    associatedtype Theme: Styfler.Theme
}

public extension DefaultStylable {
    static var s: Style<Self, Theme>.Type {
        return Style<Self, Theme>.self
    }

    var s: Style<Self, Theme>.Type {
        return Style<Self, Theme>.self
    }
}
