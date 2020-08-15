//
//  ViewProxyProvidingView.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

public protocol ViewProxyProvidingView: UIView {}

extension ViewProxyProvidingView {
    
    /// SweetUI DSL for the caller instance.
    ///
    /// ViewDSL, initialized by the caller instance.
    public var ui: ViewProxy<Self> { .init(self) }
    
}

extension UIView: ViewProxyProvidingView {}
