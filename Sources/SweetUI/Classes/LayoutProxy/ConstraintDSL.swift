//
//  ConstraintDSL.swift
//  SweetUI
//
//  Created by Maxim Krouk on 8/14/20.
//

import UIKit

protocol AnyLayoutAnchor {
    func constraint(equalTo anchor: Self) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self) -> NSLayoutConstraint
    func constraint(equalTo anchor: Self, constant c: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant c: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant c: CGFloat) -> NSLayoutConstraint
}

extension NSLayoutAnchor: AnyLayoutAnchor {}

struct Pair<First, Second> {
    var first: First
    var second: Second
    
    init(_ pair: (First, Second)) {
        self.init(pair.0, pair.1)
    }
    
    init(_ first: First, _ second: Second) {
        self.init(first: first, second: second)
    }
    
    init(first: First, second: Second) {
        self.first = first
        self.second = second
    }
    
    func inverted() -> Pair<Second, First> {
        return .init(first: second, second: first)
    }
}

func constraint(
    _ anchorPair: Pair<NSLayoutDimension, NSLayoutDimension>,
    compare: ConstraintDSL.Compare = .equal,
    modifier: ConstraintDSL.DimensionModifier? = .none
) -> NSLayoutConstraint {
    switch modifier {
    case .none:
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second)
        }
    case .inset(let value):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, constant: -value)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, constant: -value)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, constant: -value)
        }
    case .offset(let value):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, constant: value)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, constant: value)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, constant: value)
        }
    case .multiplier(let value):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, multiplier: value)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, multiplier: value)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, multiplier: value)
        }
    case .combined(multiplier: let multiplier, constant: let constant):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, multiplier: multiplier, constant: constant)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, multiplier: multiplier, constant: constant)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, multiplier: multiplier, constant: constant)
        }
    }
}

func constraint(
    _ anchorPair: Pair<NSLayoutXAxisAnchor, NSLayoutXAxisAnchor>,
    compare: ConstraintDSL.Compare = .equal,
    modifier: ConstraintDSL.AxisModifier? = .none
) -> NSLayoutConstraint {
    switch modifier {
    case .none:
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second)
        }
    case .inset(let value):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, constant: -value)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, constant: -value)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, constant: -value)
        }
    case .offset(let value):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, constant: value)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, constant: value)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, constant: value)
        }
    }
}

func constraint(
    _ anchorPair: Pair<NSLayoutYAxisAnchor, NSLayoutYAxisAnchor>,
    compare: ConstraintDSL.Compare = .equal,
    modifier: ConstraintDSL.AxisModifier? = .none
) -> NSLayoutConstraint {
    switch modifier {
    case .none:
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second)
        }
    case .inset(let value):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, constant: -value)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, constant: -value)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, constant: -value)
        }
    case .offset(let value):
        switch compare {
        case .less:
            return anchorPair.first.constraint(lessThanOrEqualTo: anchorPair.second, constant: value)
        case .equal:
            return anchorPair.first.constraint(equalTo: anchorPair.second, constant: value)
        case .greater:
            return anchorPair.first.constraint(greaterThanOrEqualTo: anchorPair.second, constant: value)
        }
    }
}

struct ConstraintDSL {
    enum Compare {
        case less
        case equal
        case greater
    }
    
    enum Single {
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
    
    
    enum DimensionModifier {
        case inset(CGFloat)
        case offset(CGFloat)
        case multiplier(CGFloat)
        case combined(multiplier: CGFloat, constant: CGFloat)
    }
    
    enum Dimension {
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
    
    enum AxisModifier {
        case inset(CGFloat)
        case offset(CGFloat)
    }
    
    enum XAxis {
        case left
        case right
        case leading
        case trailing
        case centerX
        
        
        func anchor(for view: UIView) -> NSLayoutXAxisAnchor {
            switch self {
            case .left      : return view.leftAnchor
            case .right     : return view.rightAnchor
            case .leading   : return view.leadingAnchor
            case .trailing  : return view.trailingAnchor
            case .centerX   : return view.centerXAnchor
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
    
    enum YAxis {
        case top
        case bottom
        case centerY
        
        func anchor(for view: UIView) -> NSLayoutYAxisAnchor {
            switch self {
            case .top       : return view.topAnchor
            case .bottom    : return view.bottomAnchor
            case .centerY   : return view.centerYAnchor
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
