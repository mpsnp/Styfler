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

    public var borderWidth: CGFloat

    public var colors: Colors
    public var cornerRadiuses: CornerRadiuses
    public var textStyles: TextStyles
}

extension UIView: DefaultStylable {
    public typealias Theme = AppTheme
}

extension AppTheme.Colors {
    static let light: AppTheme.Colors = .init(
        primary: .white,
        secondary: .init(hex: 0xBABABA),
        border: .init(hex: 0xCACACA),
        buttonText: .white
    )

    static let dark: AppTheme.Colors = .init(
        primary: .init(hex: 0x3E3D3C),
        secondary: .init(hex: 0xBABABA),
        border: .init(hex: 0x888888),
        buttonText: .black
    )
}

extension AppTheme {
    static let light: AppTheme = AppTheme(
        borderWidth: 1.0,
        colors: .light,
        cornerRadiuses: .init(
            standard: 4.0
        ),
        textStyles: .init()
    )

    static let dark: AppTheme = AppTheme(
        borderWidth: 3.0,
        colors: .dark,
        cornerRadiuses: .init(
            standard: 12.0
        ),
        textStyles: .init()
    )
}

public extension UIColor {
    /// Constructs color from hex of rgb and percentage of alpha in range 0..1
    ///
    /// - Parameters:
    ///   - hex: rgb representation of color
    ///   - alpha: value in percentage: from 0 to 1, defaults to 1
    public convenience init(hex: UInt32, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat(hex >> (8 * 2) & 255) / 255,
            green: CGFloat(hex >> (8 * 1) & 255) / 255,
            blue: CGFloat(hex >> (8 * 0) & 255) / 255,
            alpha: alpha
        )
    }
}
