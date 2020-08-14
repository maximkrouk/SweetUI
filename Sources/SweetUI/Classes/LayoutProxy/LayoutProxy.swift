//
//  LayoutDSL.swift
//  SweetUI
//
//  Created by Maxim Krouk on 8/14/20.
//

import UICocoa

extension Array {
    mutating func mutatingForEach(_ transform: (inout Element) -> Void) {
        self = self.inoutForEach(transform)
    }
    
    func inoutForEach(_ transform: (inout Element) -> Void) -> Self {
        var copy = self
        indices.forEach { index in
            var element = copy[index]
            transform(&element)
            copy[index] = element
        }
        return copy
    }
}

protocol FutureLayoutConfigurator {
    func configureLayout()
}

protocol LayoutProxyProvidingView: UIView {}

extension LayoutProxyProvidingView {
    public var layout: LayoutProxy<Self> { .init(self) }
}

extension UIView: LayoutProxyProvidingView {}

public struct LayoutProxy<Base: UIView>: UIViewProvider, FutureLayoutConfigurator {
    func configureLayout() { perform() }
    
    struct FutureLayoutConfiguration {
        internal init(
            singles: [SingleItem] = [],
            axisLayouts: [(ConstraintDSL.AxisModifier?) -> FutureLayout] = [],
            dimensionLayouts: [(ConstraintDSL.DimensionModifier?) -> FutureLayout] = [],
            futureLayouts: [FutureLayout] = []
        ) {
            self.singles = singles
            self.axisLayouts = axisLayouts
            self.dimensionLayouts = dimensionLayouts
            self.futureLayouts = futureLayouts
        }
        
        typealias FutureLayout = () -> Void
        struct SingleItem {
            internal init(
                _ wrapped: ConstraintDSL.Single,
                _ priority: UILayoutPriority? = .none
            ) {
                self.wrapped = wrapped
                self.priority = priority
            }
            
            var wrapped: ConstraintDSL.Single
            var priority: UILayoutPriority? = .none
            
            static func single(_ item: ConstraintDSL.Single) -> Self { .init(item) }
        }
        
        var singles: [SingleItem]
        var axisLayouts: [(ConstraintDSL.AxisModifier?) -> FutureLayout] = []
        var dimensionLayouts: [(ConstraintDSL.DimensionModifier?) -> FutureLayout] = []
        var futureLayouts: [FutureLayout] = []
        
        func prepared() -> Self {
            var futureLayouts = self.futureLayouts
            futureLayouts.append(
                contentsOf: axisLayouts.map { $0(.none) }
            )
            futureLayouts.append(
                contentsOf: dimensionLayouts.map { $0(.none) }
            )
            return .init(futureLayouts: futureLayouts)
        }
    }
    
    internal var configuration: FutureLayoutConfiguration
    
    /// Stored view, managed by the DSL.
    public let base: Base
    public var view: UIView { base }
    public var ui: ViewProxy<Base> { .init(base, layout: self) }
    
    /// Initializes and returns a newly allocated dsl object with specified managed view.
    ///
    /// - Parameter content: Closure, that specifies managed view.
    public init(_ base: Base) {
        self.base = base
        self.configuration = .init()
    }
    
    internal init(
        _ base: Base,
        configuration: FutureLayoutConfiguration
    ) {
        self.base = base
        self.configuration = configuration
    }
    
    @discardableResult
    func perform() -> Self {
        let configuration = self.configuration.prepared()
        configuration.futureLayouts.forEach { $0() }
        return .init(base, configuration: .init())
    }
}

extension LayoutProxy {
    var edges: LayoutProxy<Base> {
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
    
    func priority(_ priority: UILayoutPriority) -> Self {
        var configuration = self.configuration
        configuration.singles.mutatingForEach { element in
            if element.priority == nil { element.priority = priority }
        }
        return .init(base, configuration: configuration)
    }
    
    func pinToSuperview() -> LayoutProxy<Base> {
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
    
    func modifier(_ modifier: ConstraintDSL.AxisModifier?) -> LayoutProxy<Base> {
        var configuration = self.configuration
        configuration.futureLayouts
            .append(contentsOf: configuration.axisLayouts.map { $0(modifier) })
        return .init(base, configuration: configuration)
    }
    
    func modifier(_ modifier: ConstraintDSL.DimensionModifier?) -> LayoutProxy<Base> {
        var configuration = self.configuration
        configuration.futureLayouts
            .append(contentsOf: configuration.dimensionLayouts.map { $0(modifier) })
        return .init(base, configuration: configuration)
    }

}
