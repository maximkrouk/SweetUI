//
//  CABasicKeyPathAnimation.swift
//  PropertyWrapprs-tries
//
//  Created by Maxim Krouk on 3/14/20.
//  Copyright © 2020 Maxim Krouk. All rights reserved.
//

import UIKit

public class CABasicKeyPathDrivenAnimation<Layer: CALayer, Value>: CABasicAnimation, CAKeyPathDrivenAnimation {
    
    public func run() {
        guard
            let layer = _delegate?.layer,
            let path = _delegate?.keyPath
        else { return }
        fromValue = layer[keyPath: path]
        layer.add(self, forKey: path.asString)
    }
    
}
