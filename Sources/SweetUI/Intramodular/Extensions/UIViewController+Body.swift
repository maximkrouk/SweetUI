//
//  File.swift
//  
//
//  Created by Maxim Krouk on 8/17/20.
//

import UICocoa

extension UIViewController {
    public func setBody(content: () -> UIView) {
        setBody(content())
    }
    
    public func setBody(_ content: UIView) {
        self.view = content
    }
}

extension UIView {
    public func setBody(content: () -> UIView) {
        setBody(content())
    }
    
    public func setBody(_ content: UIView) {
        discard(subviews.map { $0.removeFromSuperview() })
        addSubview(content)
        content.layout.edges
            .equalToSuperview()
            .perform()
    }
}
