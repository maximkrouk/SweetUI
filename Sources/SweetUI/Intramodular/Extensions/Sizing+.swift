//
//  Sizing+.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

public extension CGSize {
    
    /// Current screen size.
    static var screen: CGSize { CGRect.screen.size }
    
    static func square(_ length: CGFloat) -> CGSize { .init(width: length, height: length) }
    
}

public extension CGRect {
    
    /// Current screen bounds.
    static var screen: CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #elseif os(macOS)
        return CGRect(origin: .zero, size: (NSScreen.main?.frame.size) ?? .zero)
        #endif
    }
    
}
