//
//  CATransform3D+Extension.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import Foundation
import UIKit

extension CGAffineTransform {
    public var transform3D: CATransform3D { .affine(self) }
}

extension CATransform3D {
    public static var identity: Self { CATransform3DIdentity }
    
    public static func translate(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> Self {
        CATransform3DMakeTranslation(x, y, z)
    }
    
    public static func scale(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> Self {
        CATransform3DMakeScale(x, y, z)
    }
    
    public static func affine(_ t: CGAffineTransform) -> Self {
        CATransform3DMakeAffineTransform(t)
    }
    
    public static func rotate(angle: CGFloat = .pi, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> Self {
        CATransform3DMakeRotation(angle, x, y, z)
    }
}
