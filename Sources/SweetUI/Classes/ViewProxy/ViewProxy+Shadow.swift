//
//  ViewDSL+Shadow.swift
//  Pods-SweetUI_Example
//
//  Created by Maxim Krouk on 9/4/19.
//

public extension ViewProxy {
    
    func shadow(
        _ color : UIColor = .black,
        radius  : CGFloat = 5,
        offset  : CGPoint = .zero,
        opacity : CGFloat = 0.5
    ) -> Self {
        shadow(.init(color, radius: radius, offset: offset, opacity: opacity))
    }
    
    func shadow(_ shadow: Shadow) -> Self {
        modified {
            let layer = $0.layer
            layer.shadowColor = shadow.color
            layer.shadowRadius = shadow.radius
            layer.shadowOffset = shadow.offset
            layer.shadowOpacity = shadow.opacity
        }
    }
    
}
