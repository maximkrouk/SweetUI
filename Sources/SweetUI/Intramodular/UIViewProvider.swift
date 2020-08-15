//
//  UIViewProvider.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

public protocol UIViewProvider {
    var view: UIView { get }
}

extension UIView: UIViewProvider {
    public var view: UIView { self }
}
