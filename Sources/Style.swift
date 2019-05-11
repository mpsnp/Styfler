//
//  Style.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation

public struct StylingOptions {
    public enum Animation {
        case none
        case animated(duration: Double, curve: UIView.AnimationCurve)
    }

    public var animation: Animation
}

public extension StylingOptions {
    static let none: StylingOptions = .init(animation: .none)

    static func animated(duration: Double = 0.25, curve: UIView.AnimationCurve = .easeInOut) -> StylingOptions {
        return .init(animation: .animated(duration: duration, curve: curve))
    }
}

public struct Style<Stylable, Theme> where Stylable: AnyObject, Theme: Styfler.Theme {
    private let style: (Stylable, Theme, StylingOptions) -> Void

    private init(style: @escaping (Stylable, Theme, StylingOptions) -> Void) {
        self.style = style
    }

    public func apply(to stylable: Stylable, with theme: Theme, options: StylingOptions = .none) {
        style(stylable, theme, options)
    }
}

public extension Style {
    static func custom(style: @escaping (Stylable, Theme, StylingOptions) -> Void) -> Style {
        return .init(style: style)
    }
}

public extension Style {
    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V>, to value: V) -> Style {
        return .init { stylable, theme, options in
            stylable[keyPath: target] = value
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V?>, to value: V) -> Style {
        return .init { stylable, theme, options in
            stylable[keyPath: target] = .some(value)
        }
    }
}

public extension Style {
    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V>, from source: KeyPath<Theme, V>) -> Style {
        return .init { stylable, theme, options in
            stylable[keyPath: target] = theme[keyPath: source]
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V?>, from source: KeyPath<Theme, V>) -> Style {
        return .init { stylable, theme, options in
            stylable[keyPath: target] = theme[keyPath: source]
        }
    }
}

public extension Style {
    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V>, copying source: KeyPath<Stylable, V>) -> Style {
        return .init { stylable, theme, options in
            stylable[keyPath: target] = stylable[keyPath: source]
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V?>, copying source: KeyPath<Stylable, V>) -> Style {
        return .init { stylable, theme, options in
            stylable[keyPath: target] = stylable[keyPath: source]
        }
    }
}

public extension Style {
    func lift<Parent>(to kp: KeyPath<Parent, Stylable>) -> Style<Parent, Theme> where Parent: AnyObject {
        return .init { parent, theme, options in
            self.apply(to: parent[keyPath: kp], with: theme, options: options)
        }
    }

    static func <<< <Parent: AnyObject>(lhs: KeyPath<Parent, Stylable>, rhs: Style) -> Style<Parent, Theme> {
        return rhs.lift(to: lhs)
    }
}

public extension Style {
    static func `if`(_ condition: KeyPath<Stylable, Bool>, _ then: Style) -> Style {
        return Style { stylable, theme, options in
            if stylable[keyPath: condition] {
                then.apply(to: stylable, with: theme, options: options)
            }
        }
    }

    static func `if`(_ condition: KeyPath<Stylable, Bool>, then: Style, else alternative: Style) -> Style {
        return Style { stylable, theme, options in
            if stylable[keyPath: condition] {
                then.apply(to: stylable, with: theme, options: options)
            } else {
                alternative.apply(to: stylable, with: theme, options: options)
            }
        }
    }
}

public extension Style {
    static var empty: Style {
        return .init { _, _, _  in }
    }

    static func <> (lhs: Style, rhs: Style) -> Style {
        return .init { stylable, theme, options in
            lhs.apply(to: stylable, with: theme, options: options)
            rhs.apply(to: stylable, with: theme, options: options)
        }
    }

    static func <> (lhs: Style.Type, rhs: Style) -> Style {
        return rhs
    }
}
