//
//  LayoutProxyStep.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//


public protocol LayoutProxyStep {}

public enum LayoutProxySteps {
    public enum Initial: LayoutProxyStep {}
    public enum Modification: LayoutProxyStep {}
    public enum Final: LayoutProxyStep {}
}
