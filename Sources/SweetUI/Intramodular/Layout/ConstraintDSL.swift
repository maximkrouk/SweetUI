//
//  ConstraintDSL.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

extension ConstraintDSL {
    public enum DimensionModifier {
        case inset(CGFloat)
        case offset(CGFloat)
        case multiplier(CGFloat)
        case combined(multiplier: CGFloat, constant: CGFloat)
    }
    
    public enum AxisModifier {
        case inset(CGFloat)
        case offset(CGFloat)
    }
}

public struct ConstraintDSL {
    enum Compare: Equatable, Hashable {
        case less
        case equal
        case greater
    }
    
    enum Single: Equatable, Hashable {
        case dimension(Dimension)
        case xAxis(XAxis)
        case yAxis(YAxis)
        
        var dimensionPair: Pair<Dimension, Dimension>? {
            guard case let .dimension(value) = self else { return nil }
            return .init(value, value)
        }
        
        var xAxisPair: Pair<XAxis, XAxis>? {
            guard case let .xAxis(value) = self else { return nil }
            return .init(value, value)
        }
        
        var yAxisPair: Pair<YAxis, YAxis>? {
            guard case let .yAxis(value) = self else { return nil }
            return .init(value, value)
        }
    }
    
    enum Dimension: Equatable, Hashable {
        case width
        case height
        
        func anchor(for view: UIView) -> NSLayoutDimension {
            switch self {
            case .width  : return view.widthAnchor
            case .height : return view.heightAnchor
            }
        }
        
        static func constraint<V1: UIView, V2: UIView>(
            _ viewPair: Pair<V1, V2>,
            with dimensionPair: Pair<Dimension, Dimension>,
            compare: Compare = .equal,
            modifier: DimensionModifier? = .none
        ) -> NSLayoutConstraint {
            SweetUI.constraint(
                Pair(
                    first: dimensionPair.first.anchor(for: viewPair.first),
                    second: dimensionPair.second.anchor(for: viewPair.second)
                ),
                compare: compare,
                modifier: modifier
            )
        }
    }
    
    enum XAxis: Equatable, Hashable {
        case left
        case right
        case leading
        case trailing
        case center
        
        func anchor(for view: UIView) -> NSLayoutXAxisAnchor {
            switch self {
            case .left      : return view.leftAnchor
            case .right     : return view.rightAnchor
            case .leading   : return view.leadingAnchor
            case .trailing  : return view.trailingAnchor
            case .center   : return view.centerXAnchor
            }
        }
        
        static func constraint<V1: UIView, V2: UIView>(
            _ viewPair: Pair<V1, V2>,
            with xAxisPair: Pair<XAxis, XAxis>,
            compare: Compare = .equal,
            modifier: AxisModifier? = .none
        ) -> NSLayoutConstraint {
            SweetUI.constraint(
                Pair(
                    first: xAxisPair.first.anchor(for: viewPair.first),
                    second: xAxisPair.second.anchor(for: viewPair.second)
                ),
                compare: compare,
                modifier: modifier
            )
        }
    }
    
    enum YAxis: Equatable, Hashable {
        case top
        case bottom
        case center
        
        func anchor(for view: UIView) -> NSLayoutYAxisAnchor {
            switch self {
            case .top       : return view.topAnchor
            case .bottom    : return view.bottomAnchor
            case .center   : return view.centerYAnchor
            }
        }
        
        enum Modifier {
            case inset(CGFloat)
            case offset(CGFloat)
        }
        
        static func constraint<V1: UIView, V2: UIView>(
            _ viewPair: Pair<V1, V2>,
            with yAxisPair: Pair<YAxis, YAxis>,
            compare: Compare = .equal,
            modifier: AxisModifier? = .none
        ) -> NSLayoutConstraint {
            SweetUI.constraint(
                Pair(
                    first: yAxisPair.first.anchor(for: viewPair.first),
                    second: yAxisPair.second.anchor(for: viewPair.second)
                ),
                compare: compare,
                modifier: modifier
            )
        }
    }
}
