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
    init<V>(
        set target: ReferenceWritableKeyPath<Stylable, V>,
        from source: KeyPath<Theme, V>,
        animated: Bool
    ) {
        self.init { layer, theme in

            if animated, let keyPathString = target._kvcKeyPathString {
                let animation = CABasicAnimation(keyPath: keyPathString)
                animation.fromValue = layer[keyPath: target]
                animation.toValue = theme[keyPath: source]
                animation.duration = 0.25
                layer.add(animation, forKey: keyPathString)
            }

            layer[keyPath: target] = theme[keyPath: source]
        }
    }

    init<V>(
        set target: ReferenceWritableKeyPath<Stylable, V>,
        to value: V,
        animated: Bool
    ) {
        self.init { layer, theme in

            if animated, let keyPathString = target._kvcKeyPathString {
                let animation = CABasicAnimation(keyPath: keyPathString)
                animation.fromValue = layer[keyPath: target]
                animation.toValue = value
                animation.duration = 0.25
                layer.add(animation, forKey: keyPathString)
            }

            layer[keyPath: target] = value
        }
    }
}
