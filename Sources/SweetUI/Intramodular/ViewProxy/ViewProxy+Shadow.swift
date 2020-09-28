//
//  ViewProxy+Shadow.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

#if os(iOS)

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

#elseif os(macOS)

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
            layer?.shadowColor = shadow.color
            layer?.shadowRadius = shadow.radius
            layer?.shadowOffset = shadow.offset
            layer?.shadowOpacity = shadow.opacity
        }
    }
    
}

#endif
