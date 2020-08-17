//
//  CAAnimation+StaticFactory.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

extension CAAnimation {
    
    public static func mutating<Layer: CALayer, Value>(
        _ layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        to value: Value,
        duration: CFTimeInterval
    ) -> CABasicKeyPathDrivenAnimation<Layer, Value> {
        basic(layer, keyPath, to: value, duration: duration).mutating()
    }
    
    public static func mutating<Layer: CALayer, Value>(
        _ layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        by value: Value,
        duration: CFTimeInterval
        ) -> CABasicKeyPathDrivenAnimation<Layer, Value> {
            basic(layer, keyPath, by: value, duration: duration).mutating()
    }
    
    public static func basic<Layer: CALayer, Value>(
        _ layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        to value: Value,
        duration: CFTimeInterval
    ) -> CABasicKeyPathDrivenAnimation<Layer, Value> {
        CABasicKeyPathDrivenAnimation(
            on: layer, keyPath,
            to: value,
            duration: duration
        )
    }
    
    public static func basic<Layer: CALayer, Value>(
        _ layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        by value: Value,
        duration: CFTimeInterval
    ) -> CABasicKeyPathDrivenAnimation<Layer, Value> {
        CABasicKeyPathDrivenAnimation(
            on: layer, keyPath,
            by: value,
            duration: duration
        )
    }
    
    public static func infinite<Layer: CALayer, Value>(
        _ layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        from: Value,
        to: Value,
        duration: CFTimeInterval
    ) -> CAInfiniteKeyPathAnimation<Layer, Value> {
        CAInfiniteKeyPathAnimation(
            on: layer, keyPath,
            from: from, to: to,
            duration: duration
        )
    }
    
    public static func infinite<Layer: CALayer, Value>(
        _ layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        from: Value,
        by: Value,
        duration: CFTimeInterval
    ) -> CAInfiniteKeyPathAnimation<Layer, Value> {
        CAInfiniteKeyPathAnimation(
            on: layer, keyPath,
            from: from, by: by,
            duration: duration
        )
    }
    
}
