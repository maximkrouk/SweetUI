//
//  ViewProvider.swift
//  Pods-SweetUI_Example
//
//  Created by Maxim Krouk on 9/4/19.
//

public protocol UIViewProvider {
    var view: UIView { get }
}

extension UIView: UIViewProvider {
    
    public var view: UIView { self }
    
}
