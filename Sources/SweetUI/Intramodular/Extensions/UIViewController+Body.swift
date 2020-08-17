//
//  File.swift
//  
//
//  Created by Maxim Krouk on 8/17/20.
//

import UICocoa

extension UIViewController {
    /// Sets a new view to a `view` property
    ///
    /// Note:
    /// - Layout config for Layout and View proxies is dropped
    public func setBody(content: () -> UIViewProvider) {
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
    /// - This method constrain content edges to self
    /// - Layout config for Layout and View proxies is dropped
    public func setBody(content: () -> UIViewProvider) {
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
