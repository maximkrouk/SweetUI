//
//  CAAnimation+Extension.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

extension CAAnimation {
    
    func mutating() -> Self {
        fillMode = .forwards
        isRemovedOnCompletion = false
        return self
    }
    
}

extension CAPropertyAnimation {
    
    public convenience init<Layer: CALayer, Value>(
        on layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        duration: CFTimeInterval
    ) {
        self.init()
        self.keyPath = keyPath.asString
        self.duration = duration
        self.delegate = CAKeyPathDrivenAnimationDelegate<Layer, Value>(layer: layer, keyPath)
    }
    
}

extension CABasicAnimation {
    
    public convenience init<Layer: CALayer, Value>(
        on layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        to value: Value,
        duration: CFTimeInterval
    ) {
        self.init(on: layer, keyPath, duration: duration)
        self.toValue = value
    }
    
    public convenience init<Layer: CALayer, Value>(
        on layer: Layer,
        _ keyPath: WritableKeyPath<Layer, Value>,
        by value: Value,
        duration: CFTimeInterval
    ) {
        self.init(on: layer, keyPath, duration: duration)
        self.byValue = value
    }
    
}
