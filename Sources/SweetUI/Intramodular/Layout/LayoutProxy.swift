//
//  LayoutProxy.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

public struct LayoutProxy<Base: UIView> {
    /// Stored view, managed by the DSL.
    public let base: Base
    public var ui: ViewProxy<Base> { .init(base, layout: self) }
    
    internal var configuration: FutureLayoutConfiguration
    
    /// Initializes and returns a newly allocated dsl object with specified managed view.
    ///
    /// - Parameter content: Closure, that specifies managed view.
    internal init(_ base: Base) {
        self.init(base, configuration: .init())
    }
    
    internal init(
        _ base: Base,
        configuration: FutureLayoutConfiguration
    ) {
        self.base = base
        self.configuration = configuration
    }
}

extension LayoutProxy: UIViewProvider {
    public var view: UIView { base }
}

extension LayoutProxy: FutureLayoutConfigurator {
    func configureLayout() { perform() }
}

extension LayoutProxy {
    
    public var edges: LayoutProxy<Base> {
        var configuration = self.configuration
        configuration.singles.append(
            contentsOf: [
                .single(.yAxis(.top)),
                .single(.yAxis(.bottom)),
                .single(.xAxis(.leading)),
                .single(.xAxis(.trailing))
            ]
        )
        return .init(base, configuration: configuration)
    }
    
    public func pinToSuperview() -> LayoutProxy<Base> {
        base.translatesAutoresizingMaskIntoConstraints = false
        var configuration = self.configuration
        configuration.singles.forEach { single in
            let viewPair = Pair(base, base.superview!)
            if let pair = single.wrapped.dimensionPair {
                configuration.dimensionLayouts.append { modifier in
                    { ConstraintDSL.Dimension.constraint(viewPair, with: pair, modifier: modifier).isActive = true }
                }
            } else if let pair = single.wrapped.xAxisPair {
                configuration.axisLayouts.append { modifier in
                    { ConstraintDSL.XAxis.constraint(viewPair, with: pair, modifier: modifier).isActive = true }
                }
            } else if let pair = single.wrapped.yAxisPair {
                configuration.axisLayouts.append { modifier in
                    { ConstraintDSL.YAxis.constraint(viewPair, with: pair, modifier: modifier).isActive = true }
                }
            }
        }
        return .init(base, configuration: configuration)
    }
    
    public func priority(_ priority: UILayoutPriority) -> Self {
        var configuration = self.configuration
        configuration.singles.mutatingForEach { element in
            if element.priority == nil { element.priority = priority }
        }
        return .init(base, configuration: configuration)
    }
    
    public func modifier(_ modifier: ConstraintDSL.AxisModifier?) -> LayoutProxy<Base> {
        var configuration = self.configuration
        configuration.futureLayouts
            .append(contentsOf: configuration.axisLayouts.map { $0(modifier) })
        return .init(base, configuration: configuration)
    }
    
    public func modifier(_ modifier: ConstraintDSL.DimensionModifier?) -> LayoutProxy<Base> {
        var configuration = self.configuration
        configuration.futureLayouts
            .append(contentsOf: configuration.dimensionLayouts.map { $0(modifier) })
        return .init(base, configuration: configuration)
    }
    
    @discardableResult
    public func perform() -> Self {
        let configuration = self.configuration.prepared()
        configuration.futureLayouts.forEach { $0() }
        return .init(base, configuration: .init())
    }
}
