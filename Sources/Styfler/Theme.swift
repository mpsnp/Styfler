//
//  Theme.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation
import UIKit

public protocol TextStyle {
    var font: UIFont { get }
}

public protocol AttributedTextStyle: TextStyle {
    var lineHeight: CGFloat { get }
    var letterSpacing: CGFloat { get }
}

public protocol ShadowStyle {
    var color: UIColor { get }
    var opacity: Float { get }
    var radius: CGFloat { get }
    var offset: CGSize { get }
}

public protocol GradientStyle {
    associatedtype BaseTheme: Theme

    var startColor: KeyPath<BaseTheme.Colors, UIColor> { get }
    var endColor: KeyPath<BaseTheme.Colors, UIColor> { get }
    var startPoint: CGPoint { get }
    var endPoint: CGPoint { get }
}

public protocol Theme {
    associatedtype Colors
    associatedtype CornerRadiuses
    associatedtype TextStyles
    associatedtype ShadowStyles
    associatedtype GradientStyles

    var colors: Colors { get }
    var cornerRadiuses: CornerRadiuses { get }
    var textStyles: TextStyles { get }
    var shadowStyles: ShadowStyles { get }
    var gradientStyles: GradientStyles { get }
}

public extension Style {
    typealias Colors = Theme.Colors
    typealias CornerRadiuses = Theme.CornerRadiuses
    typealias TextStyles = Theme.TextStyles
    typealias ShadowStyles = Theme.ShadowStyles
    typealias GradientStyles = Theme.GradientStyles
}
