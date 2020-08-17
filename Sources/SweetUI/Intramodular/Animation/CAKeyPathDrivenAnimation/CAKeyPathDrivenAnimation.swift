//
//  CAKeyPathDrivenAnimation.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

/// Use like [Animation].forEach(run)
public func run<Animation: CAKeyPathDrivenAnimation>(animation: Animation) { animation.run() }

public protocol CAKeyPathDrivenAnimation: CAAnimation {
    typealias Delegate = CAKeyPathDrivenAnimationDelegate<Layer, Value>
    associatedtype Layer: CALayer
    associatedtype Value
    var _delegate: Delegate? { get }
    func run()
}

extension CAKeyPathDrivenAnimation {
    private(set) public var _delegate: Delegate? {
        get { delegate as? Delegate }
        set { delegate = newValue }
    }
    
    public func run(after delay: DispatchTimeInterval) {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + delay,
            execute: run
        )
    }
}
