//
//  Stylable.swift
//  Styfler
//
//  Created by George Kiriy on 15/03/2019.
//

import Foundation
import UIKit

public protocol Stylable: AnyObject {
}

public extension Stylable {
    func style<T: Theme>(with theme: T, options: StylingOptions = .default) -> Styler<Self, T> {
        return Styler(instance: self, theme: theme, options: options)
    }

    static func <<< <T: Theme>(stylable: Self, theme: T) -> Styler<Self, T> {
        return Styler(instance: stylable, theme: theme, options: .default)
    }
}

extension UIViewController: Stylable {}
