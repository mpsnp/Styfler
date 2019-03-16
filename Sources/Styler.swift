//
//  Styler.swift
//  Styfler-iOS
//
//  Created by George Kiriy on 15/03/2019.
//  Copyright © 2019 Styfler. All rights reserved.
//

import Foundation

public struct Styler<Stylable: Styfler.Stylable, Theme: Styfler.Theme> {
    let instance: Stylable
    let theme: Theme
    let options: StylingOptions

    public func apply(style: Style<Stylable, Theme>) {
        style.apply(to: instance, with: theme, options: options)
    }

    public static func <| (styler: Styler, style: Style<Stylable, Theme>) {
        styler.apply(style: style)
    }
}
