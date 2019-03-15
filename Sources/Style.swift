//
//  Style.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation

public struct Style<Stylable, Theme> where Stylable: AnyObject, Theme: Styfler.Theme {
    private let style: (Stylable, Theme) -> Void

    public init(style: @escaping (Stylable, Theme) -> Void) {
        self.style = style
    }

    public func apply(to stylable: Stylable, with theme: Theme) {
        style(stylable, theme)
    }
}

extension Style {
    public init<V>(copy source: KeyPath<Theme, V>, to destination: ReferenceWritableKeyPath<Stylable, V>) {
        style = { stylable, theme in
            stylable[keyPath: destination] = theme[keyPath: source]
        }
    }

    public init<V>(set target: ReferenceWritableKeyPath<Stylable, V>, fromTheme source: KeyPath<Theme, V>) {
        style = { stylable, theme in
            stylable[keyPath: target] = theme[keyPath: source]
        }
    }

    public init<V>(set target: ReferenceWritableKeyPath<Stylable, V>, fromSelf source: KeyPath<Stylable, V>) {
        style = { stylable, theme in
            stylable[keyPath: target] = stylable[keyPath: source]
        }
    }

    public init<V>(set target: ReferenceWritableKeyPath<Stylable, V?>, fromTheme source: KeyPath<Theme, V>) {
        style = { stylable, theme in
            stylable[keyPath: target] = theme[keyPath: source]
        }
    }

    public init<V>(set target: ReferenceWritableKeyPath<Stylable, V?>, fromSelf source: KeyPath<Stylable, V>) {
        style = { stylable, theme in
            stylable[keyPath: target] = stylable[keyPath: source]
        }
    }

    public init<V>(set target: ReferenceWritableKeyPath<Stylable, V>, to value: V) {
        style = { stylable, theme in
            stylable[keyPath: target] = value
        }
    }
}

public extension Style {
    func appending(style: Style) -> Style {
        return .init { stylable, theme in
            self.apply(to: stylable, with: theme)
            style.apply(to: stylable, with: theme)
        }
    }

    func lift<Parent>(to kp: KeyPath<Parent, Stylable>) -> Style<Parent, Theme> where Parent: AnyObject {
        return .init { parent, theme in
            self.apply(to: parent[keyPath: kp], with: theme)
        }
    }

    static func <<< <Parent: AnyObject>(lhs: KeyPath<Parent, Stylable>, rhs: Style) -> Style<Parent, Theme> {
        return rhs.lift(to: lhs)
    }
}

public extension Style {
    static var empty: Style {
        return .init { _, _ in }
    }

    static func <> (lhs: Style, rhs: Style) -> Style {
        return lhs.appending(style: rhs)
    }

    static func <> (lhs: Style.Type, rhs: Style) -> Style {
        return rhs
    }
}
