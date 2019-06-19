//
//  KeyPath+Operators.swift
//  Styfler
//
//  Created by George Kiriy on 15/03/2019.
//

import Foundation

public func >>> <A, B, C>(lhs: KeyPath<A, B>, rhs: KeyPath<B, C>) -> KeyPath<A, C> {
    return lhs.appending(path: rhs)
}

public func >>> <A, B, C>(lhs: WritableKeyPath<A, B>, rhs: KeyPath<B, C>) -> KeyPath<A, C> {
    return lhs.appending(path: rhs)
}

public func >>> <A, B, C>(lhs: WritableKeyPath<A, B>, rhs: WritableKeyPath<B, C>) -> WritableKeyPath<A, C> {
    return lhs.appending(path: rhs)
}

public func >>> <A, B, C>(lhs: KeyPath<A, B>, rhs: WritableKeyPath<B, C>) -> KeyPath<A, C> {
    return lhs.appending(path: rhs)
}
