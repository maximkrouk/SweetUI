//
//  UIView+Initializers.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

//MARK: - Init
public extension UIView {
    
    /// Initializes and returns a newly allocated view object with specified subviews added.
    ///
    /// The new view object must be inserted into the view hierarchy of a window before it can be used.
    ///
    /// - Parameter content: Closure, that specifies subviews to be added to the view hierarcy after initialization.
    convenience init(@UIViewBuilder content: UIViewBuilder.Content) {
        self.init()
        self.setBody(content())
    }
    
}
