//
//  Style+UINavigationBar.swift
//  Styfler
//
//  Created by George Kiriy on 24/03/2019.
//

import Foundation
import UIKit

extension Style where Stylable: UINavigationBar {
    static func titleTextAttributes(
        extract: @escaping (Theme) -> [NSAttributedString.Key: Any]?
    ) -> Style {
        return .custom { bar, theme, options in
            bar.titleTextAttributes = extract(theme)
        }
    }

    @available(iOS 11.0, *)
    static func largeTitleTextAttributes(
        extract: @escaping (Theme) -> [NSAttributedString.Key: Any]?
    ) -> Style {
        return .custom { bar, theme, options in
            bar.largeTitleTextAttributes = extract(theme)
        }
    }

    @available(iOS 11.0, *)
    static func prefersLargeTitles(_ prefersLargeTitles: Bool = true) -> Style {
        return .set(\.prefersLargeTitles, to: prefersLargeTitles)
    }

    static func titleVerticalPositionAdjustment(_ positionAdjustment: CGFloat, for metrics: UIBarMetrics) -> Style {
        return .custom { bar, theme, options in
            bar.setTitleVerticalPositionAdjustment(positionAdjustment, for: metrics)
        }
    }

    static func backIndicator(image: ImageProvider?) -> Style {
        return .set(\.backIndicatorImage, to: image?.image)
    }

    static func backIndicator(transitionMaskImage: ImageProvider?) -> Style {
        return .set(\.backIndicatorTransitionMaskImage, to: transitionMaskImage?.image)
    }

    static func bar(style: UIBarStyle) -> Style {
        return .set(\.barStyle, to: style)
    }

    static func bar(tintColor: KeyPath<Colors, UIColor>) -> Style {
        return .set(\.barTintColor, from: \.colors >>> tintColor)
    }

    static func shadow(image: ImageProvider?) -> Style {
        return .set(\.shadowImage, to: image?.image)
    }

    static func isTranslucent(_ isTranslucent: Bool) -> Style {
        return .set(\.isTranslucent, to: isTranslucent)
    }

    static func background(image: ImageProvider?, position: UIBarPosition = .any, metrics: UIBarMetrics) -> Style {
        return .custom { bar, theme, options in
            bar.setBackgroundImage(image?.image, for: position, barMetrics: metrics)
        }
    }
}
