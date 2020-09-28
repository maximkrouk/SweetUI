//
//  LayoutProxy.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

public enum LayoutProxyModifier {
    case inset(CGFloat)
    case offset(CGFloat)
    case multiplier(CGFloat)
    case combined(multiplier: CGFloat, constant: CGFloat)
}

public struct LayoutProxy<Base: UIView, Step: LayoutProxyStep> {
    /// Stored view, managed by the DSL.
    public let base: Base
    public var ui: ViewProxy<Base> { .init(base, childLayoutConfigurators: [self]) }
    internal let childLayoutConfigurators: [FutureLayoutConfigurator]
    internal var configuration: FutureLayoutConfiguration
    
    internal init(
        _ base: Base,
        configuration: FutureLayoutConfiguration = .init(),
        childLayoutConfigurators: [FutureLayoutConfigurator] = []
    ) {
        self.base = base
        self.configuration = configuration
        self.childLayoutConfigurators = childLayoutConfigurators
    }
    
    internal func step<T: LayoutProxyStep>(_ type: T.Type) -> LayoutProxy<Base, T> {
        .init(base, configuration: configuration, childLayoutConfigurators: childLayoutConfigurators)
    }
}

extension LayoutProxy: UIViewProvider {
    public var view: UIView { base }
}

extension LayoutProxy: FutureLayoutConfigurator {
    func configureLayout() {
        childLayoutConfigurators.forEach { $0.configureLayout() }
        perform()
    }
    
    @discardableResult
    public func perform() -> Self {
        let configuration = self.configuration.prepared()
        configuration.futureLayouts.forEach { $0() }
        return .init(base, configuration: .init())
    }
    
}
