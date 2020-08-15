//
//  LayoutProxyProvidingView.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

public protocol LayoutProxyProvidingView: UIView {}

extension LayoutProxyProvidingView {
    public var layout: LayoutProxy<Self> { .init(self) }
}

extension UIView: LayoutProxyProvidingView {}
