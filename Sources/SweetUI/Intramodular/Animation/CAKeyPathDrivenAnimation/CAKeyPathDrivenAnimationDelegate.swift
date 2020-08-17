//
//  CAKeyPathDrivenAnimationDelegate.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

public class CAKeyPathDrivenAnimationDelegate<Layer: CALayer, Value>: NSObject, CAAnimationDelegate {
    public typealias Target = WritableKeyPath<Layer, Value>
    public typealias StartAction = (CAAnimation) -> Void
    private(set) public weak var layer: Layer?
    private(set) public var keyPath: Target
    public var onStart: ((Layer?, CAAnimation) -> Void)?
    public var onStop: ((Layer?, CAAnimation, Bool) -> Void)?
    
    public init(layer: Layer, _ keyPath: Target) {
        self.layer = layer
        self.keyPath = keyPath
    }
    
    public func animationDidStart(_ anim: CAAnimation) {
        onStart?(layer, anim)
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        onStop?(layer, anim, flag)
    }
    
}
