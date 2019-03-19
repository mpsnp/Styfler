//
//  Style+CALayer.swift
//  Styfler
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation
import UIKit

extension CALayer: Stylable {}

public extension Style where Stylable: CALayer {

    private static func animate<V>(layer: Stylable, at kp: ReferenceWritableKeyPath<Stylable, V>, to value: V, with options: StylingOptions) {
        if case .animated = options.animation, let keyPathString = kp._kvcKeyPathString {
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: keyPathString)
            animation.fromValue = layer[keyPath: kp]
            animation.toValue = value

            if layer.animation(forKey: keyPathString) != nil {
                layer.removeAnimation(forKey: keyPathString)
            }

            layer.add(animation, forKey: keyPathString)

            CATransaction.setCompletionBlock {
                layer[keyPath: kp] = value
            }

            CATransaction.commit()
        } else {
            layer[keyPath: kp] = value
        }
    }

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V>, from source: KeyPath<Theme, V>) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: theme[keyPath: source], with: options)
        }
    }

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V?>, from source: KeyPath<Theme, V>) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: theme[keyPath: source], with: options)
        }
    }

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V>, to value: V) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: value, with: options)
        }
    }

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V?>, to value: V) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: value, with: options)
        }
    }

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V>, over grabber: @escaping (Stylable, Theme, StylingOptions) -> V) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: grabber(layer, theme, options), with: options)
        }
    }

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V?>, over grabber: @escaping (Stylable, Theme, StylingOptions) -> V) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: grabber(layer, theme, options), with: options)
        }
    }

    static func layer(cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return .init(set: \.cornerRadius, from: \.cornerRadiuses >>> cornerRadius)
    }

    static func layer(masksToBounds: Bool) -> Style {
        return .init(set: \.masksToBounds, to: masksToBounds)
    }

    static func layer(borderWidth: CGFloat = 1, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return .init(set: \.borderWidth, to: borderWidth)
            <> .init(set: \.borderColor, from: \.colors >>> borderColor >>> \.cgColor)
    }

    static func layer(borderWidth: KeyPath<Theme, CGFloat>, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return .init(set: \.borderWidth, from: borderWidth)
            <> .init(set: \.borderColor, from: \.colors >>> borderColor >>> \.cgColor)
    }
}
