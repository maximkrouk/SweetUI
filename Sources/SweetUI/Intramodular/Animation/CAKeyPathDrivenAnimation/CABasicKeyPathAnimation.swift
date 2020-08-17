//
//  CABasicKeyPathAnimation.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
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
