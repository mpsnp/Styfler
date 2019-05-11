//
//  Style+CALayer.swift
//  Styfler
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation
import UIKit

extension CALayer: Stylable {}

// MARK: - CALayer style initializers
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
}

public extension Style where Stylable: CALayer {
    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V>, to value: V) -> Style {
        return .custom { layer, theme, options in
            animate(layer: layer, at: target, to: value, with: options)
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V?>, to value: V) -> Style {
        return .custom { layer, theme, options in
            animate(layer: layer, at: target, to: value, with: options)
        }
    }
}

public extension Style where Stylable: CALayer {
    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V>, from source: KeyPath<Theme, V>) -> Style {
        return .custom { layer, theme, options in
            animate(layer: layer, at: target, to: theme[keyPath: source], with: options)
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V?>, from source: KeyPath<Theme, V>) -> Style {
        return .custom { layer, theme, options in
            animate(layer: layer, at: target, to: theme[keyPath: source], with: options)
        }
    }
}

public extension Style where Stylable: CALayer {
    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V>, copying source: KeyPath<Stylable, V>) -> Style {
        return .custom { layer, theme, options in
            animate(layer: layer, at: target, to: layer[keyPath: source], with: options)
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V?>, copying source: KeyPath<Stylable, V>) -> Style {
        return .custom { layer, theme, options in
            animate(layer: layer, at: target, to: layer[keyPath: source], with: options)
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V>, over grabber: @escaping (Stylable, Theme, StylingOptions) -> V) -> Style {
        return .custom { layer, theme, options in
            animate(layer: layer, at: target, to: grabber(layer, theme, options), with: options)
        }
    }

    static func set<V>(_ target: ReferenceWritableKeyPath<Stylable, V?>, over grabber: @escaping (Stylable, Theme, StylingOptions) -> V) -> Style {
        return .custom { layer, theme, options in
            Style.animate(layer: layer, at: target, to: grabber(layer, theme, options), with: options)
        }
    }

}

// MARK: - CALayer styles
extension Style where Stylable: CALayer {
    static func cornerRadius(_ cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return .set(\.cornerRadius, from: \.cornerRadiuses >>> cornerRadius)
    }

    static func masksToBounds(_ masksToBounds: Bool) -> Style {
        return .set(\.masksToBounds, to: masksToBounds)
    }

    static func border(width: KeyPath<Theme, CGFloat>, color: KeyPath<Colors, UIColor>) -> Style {
        return .set(\.borderWidth, from: width)
            <> .set(\.borderColor, from: \.colors >>> color >>> \.cgColor)
    }

    static func shadow<S: ShadowStyle>(style: KeyPath<ShadowStyles, S>) -> Style {
        return .set(\.shadowColor, from: \.shadowStyles >>> style >>> \.color.cgColor)
            <> .set(\.shadowOpacity, from: \.shadowStyles >>> style >>> \.opacity)
            <> .set(\.shadowRadius, from: \.shadowStyles >>> style >>> \.radius)
            <> .set(\.shadowOffset, from: \.shadowStyles >>> style >>> \.offset)
            <> .set(\.shadowPath) { layer, _, _ in UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath }
    }

    static func gradient<G: GradientStyle>(style: KeyPath<GradientStyles, G>) -> Style where G.BaseTheme == Theme {
        // TODO: extract to CAGradientLayer style
        return .set(\.gradientLayer.startPoint, from: \.gradientStyles >>> style >>> \.startPoint)
            <> .set(\.gradientLayer.endPoint, from: \.gradientStyles >>> style >>> \.endPoint)
            <> .set(\.gradientLayer.frame, copying: \.bounds)
            <> .set(\.gradientLayer.cornerRadius, copying: \.cornerRadius)
            <> .set(\.gradientLayer.colors) { _, theme, _ in theme[keyPath: \.gradientStyles >>> style].colors(for: theme) }
    }
}


// MARK: - Layer hierarchy helpers

extension GradientStyle {
    func colors(for theme: BaseTheme) -> [CGColor] {
        return [
            theme[keyPath: \.colors >>> startColor >>> \.cgColor],
            theme[keyPath: \.colors >>> endColor >>> \.cgColor]
        ]
    }
}

private extension String {
    static let gradientLayerName: String = "Gradient"
}

private extension CALayer {
    var gradientLayer: CAGradientLayer {
        return findSublayerOrCreate(named: .gradientLayerName)
    }

    func sendSublayerToBack(layer: CALayer) {
        layer.removeFromSuperlayer()
        self.insertSublayer(layer, at: 0)
    }

    func findSublayer(named name: String) -> CALayer? {
        return sublayers?.first(where: { $0.name == name })
    }

    func findSublayerOrCreate<Layer: CALayer>(named name: String, index: UInt32 = 0) -> Layer {
        let result: Layer
        if let foundLayer = findSublayer(named: name) as? Layer {
            result = foundLayer
        } else {
            result = Layer()
            result.name = name
            insertSublayer(result, at: index)
        }

        if sublayers?.first != result {
            sendSublayerToBack(layer: result)
        }

        return result
    }
}
