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

public protocol Theme {
    associatedtype Colors
    associatedtype CornerRadiuses
    associatedtype TextStyles

    var colors: Colors { get }
    var cornerRadiuses: CornerRadiuses { get }
    var textStyles: TextStyles { get }
}

public extension Style {
    public typealias Colors = Theme.Colors
    public typealias CornerRadiuses = Theme.CornerRadiuses
    public typealias TextStyles = Theme.TextStyles
}
