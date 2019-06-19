//
//  AppTheme.swift
//  StyflerExample
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 mpsnp. All rights reserved.
//

import Foundation
import Styfler

public struct AppTheme: Theme, Equatable {
    public struct Colors: Equatable {
        var primary: UIColor
        var secondary: UIColor
        var border: UIColor
        var buttonText: UIColor
    }

    public struct CornerRadiuses: Equatable {
        var standard: CGFloat
    }

    public struct TextStyles: Equatable {

    }
    public struct ShadowStyles: Equatable {
        public struct Style: Equatable, ShadowStyle {
            public var color: UIColor
            public var opacity: Float
            public var radius: CGFloat
            public var offset: CGSize
        }

        public var base: Style
    }
    public struct GradientStyles: Equatable {

    }

    public var borderWidth: CGFloat

    public var colors: Colors
    public var cornerRadiuses: CornerRadiuses
    public var textStyles: TextStyles
    public var shadowStyles: ShadowStyles
    public var gradientStyles: GradientStyles
}

extension AppTheme.Colors {
    static let light: AppTheme.Colors = .init(
        primary: .white,
        secondary: .init(hex: 0xBABABA),
        border: .init(hex: 0x888888),
        buttonText: .white
    )

    static let dark: AppTheme.Colors = .init(
        primary: .white,
        secondary: .init(hex: 0xBABABA),
        border: .init(hex: 0x888888),
        buttonText: .white
    )
}

extension AppTheme.ShadowStyles.Style {
    static let big: AppTheme.ShadowStyles.Style = AppTheme.ShadowStyles.Style(
        color: .init(hex: 0x444444),
        opacity: 1.0,
        radius: 20,
        offset: CGSize(width: 10, height: 10)
    )

    static let small: AppTheme.ShadowStyles.Style = AppTheme.ShadowStyles.Style(
        color: .init(hex: 0x888888),
        opacity: 1.0,
        radius: 4,
        offset: .zero
    )
}

extension AppTheme {
    static let light: AppTheme = AppTheme(
        borderWidth: 1.0,
        colors: .light,
        cornerRadiuses: .init(
            standard: 4.0
        ),
        textStyles: .init(),
        shadowStyles: .init(base: .small),
        gradientStyles: .init()
    )

    static let dark: AppTheme = AppTheme(
        borderWidth: 3.0,
        colors: .dark,
        cornerRadiuses: .init(
            standard: 12.0
        ),
        textStyles: .init(),
        shadowStyles: .init(base: .big),
        gradientStyles: .init()
    )
}

public extension UIColor {
    /// Constructs color from hex of rgb and percentage of alpha in range 0..1
    ///
    /// - Parameters:
    ///   - hex: rgb representation of color
    ///   - alpha: value in percentage: from 0 to 1, defaults to 1
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat(hex >> (8 * 2) & 255) / 255,
            green: CGFloat(hex >> (8 * 1) & 255) / 255,
            blue: CGFloat(hex >> (8 * 0) & 255) / 255,
            alpha: alpha
        )
    }
}
