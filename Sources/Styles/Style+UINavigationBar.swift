//
//  Style+UINavigationBar.swift
//  Styfler
//
//  Created by George Kiriy on 24/03/2019.
//

import Foundation

extension Style where Stylable: UINavigationBar {
    static func titleTextAttributes(
        extract: @escaping (Theme) -> [NSAttributedString.Key: Any]?
    ) -> Style {
        return Style { bar, theme, options in
            bar.titleTextAttributes = extract(theme)
        }
    }

    @available(iOS 11.0, *)
    static func largeTitleTextAttributes(
        extract: @escaping (Theme) -> [NSAttributedString.Key: Any]?
    ) -> Style {
        return Style { bar, theme, options in
            bar.largeTitleTextAttributes = extract(theme)
        }
    }

    @available(iOS 11.0, *)
    static func prefersLargeTitles(_ prefersLargeTitles: Bool = true) -> Style {
        return Style(set: \.prefersLargeTitles, to: prefersLargeTitles)
    }

    static func titleVerticalPositionAdjustment(_ positionAdjustment: CGFloat, for metrics: UIBarMetrics) -> Style {
        return Style { bar, theme, options in
            bar.setTitleVerticalPositionAdjustment(positionAdjustment, for: metrics)
        }
    }

    static func backIndicator(image: ImageProvider?) -> Style {
        return Style(set: \.backIndicatorImage, to: image?.image)
    }

    static func backIndicator(transitionMaskImage: ImageProvider?) -> Style {
        return Style(set: \.backIndicatorTransitionMaskImage, to: transitionMaskImage?.image)
    }

    static func bar(style: UIBarStyle) -> Style {
        return Style(set: \.barStyle, to: style)
    }

    static func bar(tintColor: KeyPath<Colors, UIColor>) -> Style {
        return Style(set: \.barTintColor, from: \.colors >>> tintColor)
    }

    static func shadow(image: ImageProvider?) -> Style {
        return Style(set: \.shadowImage, to: image?.image)
    }

    static func isTranslucent(_ isTranslucent: Bool) -> Style {
        return Style(set: \.isTranslucent, to: isTranslucent)
    }

    static func background(image: ImageProvider?, position: UIBarPosition = .any, metrics: UIBarMetrics) -> Style {
        return Style { bar, theme, options in
            bar.setBackgroundImage(image?.image, for: position, barMetrics: metrics)
        }
    }
}
