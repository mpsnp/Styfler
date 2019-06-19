//
//  ImageProvider.swift
//  Pods-StyflerExample
//
//  Created by George Kiriy on 16/03/2019.
//

import Foundation
import UIKit

public protocol ImageProvider {
    var image: UIImage { get }
}

extension UIImage: ImageProvider {
    public var image: UIImage {
        return self
    }
}

extension Collection where Element == ImageProvider {
    var images: [UIImage] {
        return map { $0.image }
    }
}
