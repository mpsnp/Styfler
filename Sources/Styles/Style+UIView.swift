//
//  Style+UIView.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation
import UIKit

extension UIView: Stylable {}

// MARK: - Deprecated

public extension Style where Stylable: UIView {

    @available(*, deprecated, renamed: "clipsToBounds(_:)")
    static func view(clipsToBounds: Bool = true) -> Style {
        return Style(set: \.clipsToBounds, to: clipsToBounds)
    }

    @available(*, deprecated, renamed: "isOpaque(_:)")
    static func view(isOpaque: Bool = true) -> Style {
        return Style(set: \.isOpaque, to: isOpaque)
    }

    @available(*, deprecated, renamed: "alpha(_:)")
    static func view(alpha: CGFloat) -> Style {
        return Style(set: \.alpha, to: alpha)
    }

    @available(*, deprecated, renamed: "backgroundColor(_:)")
    static func view(backgroundColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.backgroundColor, from: \.colors >>> backgroundColor)
    }

    @available(*, deprecated, renamed: "tintColor(_:)")
    static func view(tintColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, from: \.colors >>> tintColor)
    }

}

// MARK: -

public extension Style where Stylable: UIView {

    static func clipsToBounds(_ clipsToBounds: Bool = true) -> Style {
        return Style(set: \.clipsToBounds, to: clipsToBounds)
    }

    static func isOpaque(_ isOpaque: Bool = true) -> Style {
        return Style(set: \.isOpaque, to: isOpaque)
    }

    static func backgroundColor(_ backgroundColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.backgroundColor, from: \.colors >>> backgroundColor)
    }

    static func alpha(_ alpha: CGFloat) -> Style {
        return Style(set: \.alpha, to: alpha)
    }

    static func tintColor(_ tintColor: KeyPath<Theme.Colors, UIColor>) -> Style {
        return Style(set: \.tintColor, from: \.colors >>> tintColor)
    }

}

// MARK: - Layer wrappers

// MARK: - Deprecated

public extension Style where Stylable: UIView {
    @available(*, deprecated, renamed: "cornerRadius(_:)")
    static func layer(cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return \.layer <<< .layer(cornerRadius: cornerRadius)
    }

    @available(*, deprecated, renamed: "masksToBounds(_:)")
    static func layer(masksToBounds: Bool) -> Style {
        return \.layer <<< .layer(masksToBounds: masksToBounds)
    }

    @available(*, deprecated, renamed: "border(withWidth:andColor:)")
    static func layer(borderWidth: CGFloat = 1, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .layer(borderWidth: borderWidth, borderColor: borderColor)
    }

    @available(*, deprecated, renamed: "border(withWidth:andColor:)")
    static func layer(borderWidth: KeyPath<Theme, CGFloat>, borderColor: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .layer(borderWidth: borderWidth, borderColor: borderColor)
    }

}

// MARK: -

public extension Style where Stylable: UIView {
    static func cornerRadius(_ cornerRadius: KeyPath<CornerRadiuses, CGFloat>) -> Style {
        return \.layer <<< .init(set: \.cornerRadius, from: \.cornerRadiuses >>> cornerRadius)
    }

    static func masksToBounds(_ masksToBounds: Bool) -> Style {
        return \.layer <<< .init(set: \.masksToBounds, to: masksToBounds)
    }

    static func border(withWidth width: CGFloat, andColor color: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .init(set: \.borderWidth, to: width)
            <> \.layer <<< .init(set: \.borderColor, from: \.colors >>> color >>> \.cgColor)
    }

    static func border(withWidth width: KeyPath<Theme, CGFloat>, andColor color: KeyPath<Colors, UIColor>) -> Style {
        return \.layer <<< .init(set: \.borderWidth, from: width)
            <> \.layer <<< .init(set: \.borderColor, from: \.colors >>> color >>> \.cgColor)
    }

    static func shadow<S: ShadowStyle>(style: KeyPath<ShadowStyles, S>) -> Style {
        return \.layer <<< .init(set: \.shadowColor, from: \.shadowStyles >>> style >>> \.color.cgColor)
            <> \.layer <<< .init(set: \.shadowOpacity, from: \.shadowStyles >>> style >>> \.opacity)
            <> \.layer <<< .init(set: \.shadowRadius, from: \.shadowStyles >>> style >>> \.radius)
            <> \.layer <<< .init(set: \.shadowOffset, from: \.shadowStyles >>> style >>> \.offset)
            <> \.layer <<< .init(set: \.shadowPath) { layer, _, _ in UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath }
    }

    static func gradient<G: GradientStyle>(style: KeyPath<GradientStyles, G>) -> Style where G.BaseTheme == Theme {
        return \.layer <<< .init(set: \.gradientLayer.startPoint, from: \.gradientStyles >>> style >>> \.startPoint)
            <> \.layer <<< .init(set: \.gradientLayer.endPoint, from: \.gradientStyles >>> style >>> \.endPoint)
            <> \.layer <<< .init(set: \.gradientLayer.frame, copying: \.bounds)
            <> \.layer <<< .init(set: \.gradientLayer.cornerRadius, copying: \.cornerRadius)
            <> \.layer <<< .init(set: \.gradientLayer.colors) { _, theme, _ in theme[keyPath: \.gradientStyles >>> style].colors(for: theme) }
    }
}

extension GradientStyle {
    func colors(for theme: BaseTheme) -> [CGColor] {
        return [
            theme[keyPath: \.colors >>> startColor >>> \.cgColor],
            theme[keyPath: \.colors >>> endColor >>> \.cgColor]
        ]
    }
}

extension String {
    static let gradientLayerName: String = "Gradient"
}

extension CALayer {
    var gradientLayer: CAGradientLayer {
        return findSublayerOrCreate(named: .gradientLayerName)
    }
}

extension CALayer {
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
