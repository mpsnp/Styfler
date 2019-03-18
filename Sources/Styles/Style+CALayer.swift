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
        if case let .animated(duration, timingName) = options.animation, let keyPathString = kp._kvcKeyPathString {
            let animation = CABasicAnimation(keyPath: keyPathString)
            animation.fromValue = layer[keyPath: kp]
            animation.toValue = value
            animation.timingFunction = .init(name: timingName)
            animation.duration = duration
            layer.add(animation, forKey: keyPathString)
        }
        layer[keyPath: kp] = value
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

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V>, over grabber: @escaping (Stylable) -> V) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: grabber(layer), with: options)
        }
    }

    init<V>(set target: ReferenceWritableKeyPath<Stylable, V?>, over grabber: @escaping (Stylable) -> V) {
        self.init { layer, theme, options in
            Style.animate(layer: layer, at: target, to: grabber(layer), with: options)
        }
    }
}
