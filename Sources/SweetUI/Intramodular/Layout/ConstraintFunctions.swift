//
//  ConstraintFunctions.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

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
