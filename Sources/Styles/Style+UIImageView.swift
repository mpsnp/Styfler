//
//  Style+UIImageView.swift
//  Pods-StyflerExample
//
//  Created by Valeriy Mikholapov on 30/03/2019.
//

public extension Style where Stylable: UIImageView {

    static func image(_ image: ImageProvider) -> Style {
        return .init(set: \.image, to: image.image)
    }

    static func highlightedImage(_ highlightedImage: ImageProvider) -> Style {
        return .init(set: \.highlightedImage, to: highlightedImage.image)
    }

    static func animationImages(_ animationImages: [ImageProvider]) -> Style {
        return .init(set: \.animationImages, to: animationImages.images)
    }

    static func highlightedAnimationImages(_ highlightedAnimationImages: [ImageProvider]) -> Style {
        return .init(set: \.highlightedAnimationImages, to: highlightedAnimationImages.images)
    }

    static func animation(duration: TimeInterval, repeatCount: Int = 0) -> Style {
        return .init(set: \.animationDuration, to: duration)
            <> .init(set: \.animationRepeatCount, to: repeatCount)
    }

    static func isHighlighted(_ isHighlighted: Bool) -> Style {
        return .init(set: \.isHighlighted, to: isHighlighted)
    }

}
