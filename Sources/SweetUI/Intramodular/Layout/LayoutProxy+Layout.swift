//
//  LayoutProxy+Layout.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

extension LayoutProxy where Step == LayoutProxySteps.Initial {
    public var top: Self {
        _insertingAnchors(.single(.yAxis(.top)))
    }
    
    public var bottom: Self {
        _insertingAnchors(.single(.yAxis(.bottom)))
    }
    
    public var leading: Self {
        _insertingAnchors(.single(.xAxis(.leading)))
    }
    
    public var trailing: Self {
        _insertingAnchors(.single(.xAxis(.trailing)))
    }
    
    public var left: Self {
        _insertingAnchors(.single(.xAxis(.left)))
    }
    
    public var right: Self {
        _insertingAnchors(.single(.xAxis(.right)))
    }
    
    public var width: Self {
        _insertingAnchors(.single(.dimension(.width)))
    }
    
    public var height: Self {
        _insertingAnchors(.single(.dimension(.height)))
    }
    
    public var centerX: Self {
        _insertingAnchors(.single(.xAxis(.center)))
    }
    
    public var centerY: Self {
        _insertingAnchors(.single(.yAxis(.center)))
    }
    
    public var center: Self {
        self.centerX.centerY
    }
        
    public var edges: Self {
        self.top.bottom.leading.trailing
    }
    
    private func _insertingAnchors(_ items: FutureLayoutConfiguration.SingleItem...) -> Self {
        modification(of: self) { _self in
            items.forEach { _self.configuration.singles.insert($0) }
        }
    }
    
    public func priority(_ priority: UILayoutPriority) -> Self {
        modification(of: self) { _self in
            _self.configuration.singles.forEach {
                var element = $0
                if element.priority == nil { element.priority = priority }
                _self.configuration.singles.insert(element)
            }
        }
    }
}

extension LayoutProxy where Step == LayoutProxySteps.Initial {
    
    public func equalToSuperview() -> LayoutProxy<Base, LayoutProxySteps.Modification> {
        equalTo(base.superview!)
    }
    
    public func lessThanSuperview() -> LayoutProxy<Base, LayoutProxySteps.Modification> {
        lessThan(base.superview!)
    }
    
    public func greaterThanSuperview() -> LayoutProxy<Base, LayoutProxySteps.Modification> {
        greaterThan(base.superview!)
    }
    
    public func equalTo(
        _ view: @escaping @autoclosure () -> UIView
    ) -> LayoutProxy<Base, LayoutProxySteps.Modification> {
        modification(of: self) { _self in
            _self.base.translatesAutoresizingMaskIntoConstraints = false
            _self.configuration.singles.forEach { single in
                let viewPair = { Pair(base, view()) }
                if let pair = single.wrapped.dimensionPair {
                    _self.configuration.dimensionLayouts.append { modifier in
                        {
                            ConstraintDSL.Dimension.constraint(
                                viewPair(), with: pair,
                                compare: .equal, modifier: modifier
                            ).isActive = true
                        }
                    }
                } else if let pair = single.wrapped.xAxisPair {
                    _self.configuration.axisLayouts.append { modifier in
                        {
                            ConstraintDSL.XAxis.constraint(
                                viewPair(), with: pair,
                                compare: .equal, modifier: modifier
                            ).isActive = true
                        }
                    }
                } else if let pair = single.wrapped.yAxisPair {
                    _self.configuration.axisLayouts.append { modifier in
                        {
                            ConstraintDSL.YAxis.constraint(
                                viewPair(), with: pair,
                                compare: .equal, modifier: modifier
                            ).isActive = true
                        }
                    }
                }
            }
        }.step(LayoutProxySteps.Modification.self)
    }
    
    public func lessThan(
        _ view: @escaping @autoclosure () -> UIView
    ) -> LayoutProxy<Base, LayoutProxySteps.Modification> {
        modification(of: self) { _self in
            _self.base.translatesAutoresizingMaskIntoConstraints = false
            _self.configuration.singles.forEach { single in
                let viewPair = { Pair(base, view()) }
                if let pair = single.wrapped.dimensionPair {
                    _self.configuration.dimensionLayouts.append { modifier in
                        {
                            ConstraintDSL.Dimension.constraint(
                                viewPair(), with: pair,
                                compare: .less, modifier: modifier
                            ).isActive = true
                        }
                    }
                } else if let pair = single.wrapped.xAxisPair {
                    _self.configuration.axisLayouts.append { modifier in
                        {
                            ConstraintDSL.XAxis.constraint(
                                viewPair(), with: pair,
                                compare: .less, modifier: modifier
                            ).isActive = true
                        }
                    }
                } else if let pair = single.wrapped.yAxisPair {
                    _self.configuration.axisLayouts.append { modifier in
                        {
                            ConstraintDSL.YAxis.constraint(
                                viewPair(), with: pair,
                                compare: .less, modifier: modifier
                            ).isActive = true
                        }
                    }
                }
            }
        }.step(LayoutProxySteps.Modification.self)
    }
    
    public func greaterThan(
        _ view: @escaping @autoclosure () -> UIView
    ) -> LayoutProxy<Base, LayoutProxySteps.Modification> {
        modification(of: self) { _self in
            _self.base.translatesAutoresizingMaskIntoConstraints = false
            _self.configuration.singles.forEach { single in
                let viewPair = { Pair(base, view()) }
                if let pair = single.wrapped.dimensionPair {
                    _self.configuration.dimensionLayouts.append { modifier in
                        {
                            ConstraintDSL.Dimension.constraint(
                                viewPair(), with: pair,
                                compare: .greater, modifier: modifier
                            ).isActive = true
                        }
                    }
                } else if let pair = single.wrapped.xAxisPair {
                    _self.configuration.axisLayouts.append { modifier in
                        {
                            ConstraintDSL.XAxis.constraint(
                                viewPair(), with: pair,
                                compare: .greater, modifier: modifier
                            ).isActive = true
                        }
                    }
                } else if let pair = single.wrapped.yAxisPair {
                    _self.configuration.axisLayouts.append { modifier in
                        {
                            ConstraintDSL.YAxis.constraint(
                                viewPair(), with: pair,
                                compare: .greater, modifier: modifier
                            ).isActive = true
                        }
                    }
                }
            }
        }.step(LayoutProxySteps.Modification.self)
    }
}

extension LayoutProxy where Step == LayoutProxySteps.Modification {
    public func modifier(_ modifier: LayoutProxyModifier?) -> LayoutProxy<Base, LayoutProxySteps.Final> {
        modification(of: self) { _self in
            switch modifier {
            case .none:
                _self.configuration.futureLayouts
                    .append(contentsOf: _self.configuration.axisLayouts.map { $0(.none) })
                _self.configuration.futureLayouts
                    .append(contentsOf: _self.configuration.dimensionLayouts.map { $0(.none) })
                _self.configuration.axisLayouts = []
            case .inset(let value):
                _self.configuration.futureLayouts
                    .append(contentsOf: _self.configuration.axisLayouts.map { $0(.inset(value)) })
                _self.configuration.futureLayouts
                    .append(contentsOf: _self.configuration.dimensionLayouts.map { $0(.inset(value)) })
                _self.configuration.axisLayouts = []
            case .offset(let value):
                _self.configuration.futureLayouts
                    .append(contentsOf: _self.configuration.axisLayouts.map { $0(.offset(value)) })
                _self.configuration.futureLayouts
                    .append(contentsOf: _self.configuration.dimensionLayouts.map { $0(.offset(value)) })
                _self.configuration.axisLayouts = []
            case .multiplier(let value):
                _self.configuration.futureLayouts
                    .append(contentsOf: _self.configuration.dimensionLayouts.map { $0(.multiplier(value)) })
            case .combined(multiplier: let multiplier, constant: let constant):
                _self.configuration.futureLayouts.append(
                    contentsOf: _self.configuration.dimensionLayouts
                        .map { $0(.combined(multiplier: multiplier, constant: constant)) }
                )
            }
            _self.configuration.dimensionLayouts = []
        }.step(LayoutProxySteps.Final.self)
    }
    
    public var layout: LayoutProxy<Base, LayoutProxySteps.Initial> {
        .init(base, childLayoutConfigurators: [self])
    }
}

extension LayoutProxy where Step == LayoutProxySteps.Final {
    public var layout: LayoutProxy<Base, LayoutProxySteps.Initial> {
        .init(base, childLayoutConfigurators: [self])
    }
}
