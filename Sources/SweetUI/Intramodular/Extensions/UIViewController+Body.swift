//
//  UIViewController+Body.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Sets a new view to a `view` property
    ///
    /// Note:
    /// - UIViewBuilder wrapps your content into a containerView, so you should setup layout
    public func setBody(@UIViewBuilder content: UIViewBuilder.Content) {
        setBody(content())
    }
    
    /// Sets a new view to a `view` property
    ///
    /// Note:
    /// - Layout config for Layout and View proxies is dropped
    public func setBody(_ content: UIViewProvider) {
        self.view = content.view
    }
}

extension UIView {
    /// Sets a new body to a view
    ///
    /// Note:
    /// - This method removes all the subviews
    /// - UIViewBuilder wrapps your content into a containerView, so you should setup layout
    /// - This method constrain content edges of the containerView to self
    public func setBody(@UIViewBuilder content: UIViewBuilder.Content) {
        setBody(content())
    }
    
    /// Sets a new body to a view
    ///
    /// Note:
    /// - This method removes all the subviews
    /// - This method constrain content edges to self
    /// - Layout config for Layout and View proxies is dropped
    public func setBody(_ content: UIViewProvider) {
        discard(subviews.map { $0.removeFromSuperview() })
        addSubview(content.view)
        content.view.layout.edges
            .equalToSuperview()
            .perform()
    }
}
