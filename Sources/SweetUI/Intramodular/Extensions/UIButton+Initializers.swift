//
//  UIButton+Initializers.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

public extension UIButton {
    
    /// Initializes and returns a newly allocated label object with specified text, textAlignment, and color.
    ///
    /// The new view object must be inserted into the view hierarchy of a window before it can be used.
    ///
    /// - Parameter text: Text of the label.
    /// - Parameter alignment: Text alignment of the label.
    /// - Parameter color: Text color of the label.
    convenience init(title: String?, action: (() -> Void)? = nil) {
        self.init()
        self.ui.title(title)
        discard(action.map { ui.onTap(.init(action: $0)) })
    }
    
    /// Initializes and returns a newly allocated label object with specified text, textAlignment, and color.
    ///
    /// The new view object must be inserted into the view hierarchy of a window before it can be used.
    ///
    /// - Parameter text: Text of the label.
    /// - Parameter alignment: Text alignment of the label.
    /// - Parameter color: Text color of the label.
    convenience init(title: String?) {
        self.init()
        self.ui.title(title)
    }
    
}
