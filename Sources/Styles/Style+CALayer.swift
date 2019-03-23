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
}

// MARK: - CALayer styles
extension Style where Stylable: CALayer {
    static func cornerRadius(_ cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return .init(set: \.cornerRadius, from: \.cornerRadiuses >>> cornerRadius)
    }

    static func masksToBounds(_ masksToBounds: Bool) -> Style {
        return .init(set: \.masksToBounds, to: masksToBounds)
    }

    static func border(width: KeyPath<Theme, CGFloat>, color: KeyPath<Colors, UIColor>) -> Style {
        return .init(set: \.borderWidth, from: width)
            <> .init(set: \.borderColor, from: \.colors >>> color >>> \.cgColor)
    }

    static func shadow<S: ShadowStyle>(style: KeyPath<ShadowStyles, S>) -> Style {
        return .init(set: \.shadowColor, from: \.shadowStyles >>> style >>> \.color.cgColor)
            <> .init(set: \.shadowOpacity, from: \.shadowStyles >>> style >>> \.opacity)
            <> .init(set: \.shadowRadius, from: \.shadowStyles >>> style >>> \.radius)
            <> .init(set: \.shadowOffset, from: \.shadowStyles >>> style >>> \.offset)
            <> .init(set: \.shadowPath) { layer, _, _ in UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath }
    }

    static func gradient<G: GradientStyle>(style: KeyPath<GradientStyles, G>) -> Style where G.BaseTheme == Theme {
        // TODO: extract to CAGradientLayer style
        return .init(set: \.gradientLayer.startPoint, from: \.gradientStyles >>> style >>> \.startPoint)
            <> .init(set: \.gradientLayer.endPoint, from: \.gradientStyles >>> style >>> \.endPoint)
            <> .init(set: \.gradientLayer.frame, copying: \.bounds)
            <> .init(set: \.gradientLayer.cornerRadius, copying: \.cornerRadius)
            <> .init(set: \.gradientLayer.colors) { _, theme, _ in theme[keyPath: \.gradientStyles >>> style].colors(for: theme) }
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


// MARK: - Deprecations
extension Style where Stylable: CALayer {
    @available(*, deprecated, renamed: "cornerRadius(_:)")
    static func layer(cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return .init(set: \.cornerRadius, from: \.cornerRadiuses >>> cornerRadius)
    }

    @available(*, deprecated, renamed: "masksToBounds(_:)")
    static func layer(masksToBounds: Bool) -> Style {
        return .init(set: \.masksToBounds, to: masksToBounds)
    }

    @available(*, deprecated)
    static func layer(borderWidth: CGFloat = 1, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return .init(set: \.borderWidth, to: borderWidth)
            <> .init(set: \.borderColor, from: \.colors >>> borderColor >>> \.cgColor)
    }

    @available(*, deprecated, renamed: "border(width:color:)")
    static func layer(borderWidth: KeyPath<Theme, CGFloat>, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return .init(set: \.borderWidth, from: borderWidth)
            <> .init(set: \.borderColor, from: \.colors >>> borderColor >>> \.cgColor)
    }
}
