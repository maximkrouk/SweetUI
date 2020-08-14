//
//  CGRect+Extension.swift
//  SweetUI
//
//  Created by Maxim on 7/22/19.
//

public extension CGFloat {
    
    /// Current screen size.
    static var screen: CGSize { CGSize.screen }
    
}

public extension CGSize {
    
    /// Current screen size.
    static var screen: CGSize { CGRect.screen.size }
    
    static func square(length: CGFloat) -> CGSize { .init(width: length, height: length) }
    
}

public extension CGRect {
    
    /// Current screen bounds.
    static var screen: CGRect { UIScreen.main.bounds }
    
}
