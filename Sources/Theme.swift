//
//  Theme.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation

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
    public typealias Colors = Theme.Colors
    public typealias CornerRadiuses = Theme.CornerRadiuses
    public typealias TextStyles = Theme.TextStyles
    public typealias ShadowStyles = Theme.ShadowStyles
    public typealias GradientStyles = Theme.GradientStyles
}
