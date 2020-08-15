//
//  FutureLayoutConfiguration.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

extension FutureLayoutConfiguration {
    typealias FutureLayout = () -> Void
    
    struct SingleItem: Hashable {
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
}

struct FutureLayoutConfiguration {
    var singles: Set<SingleItem> = []
    var axisLayouts: [(ConstraintDSL.AxisModifier?) -> FutureLayout] = []
    var dimensionLayouts: [(ConstraintDSL.DimensionModifier?) -> FutureLayout] = []
    var futureLayouts: [FutureLayout] = []
    
    internal init(
        singles: Set<SingleItem> = [],
        axisLayouts: [(ConstraintDSL.AxisModifier?) -> FutureLayout] = [],
        dimensionLayouts: [(ConstraintDSL.DimensionModifier?) -> FutureLayout] = [],
        futureLayouts: [FutureLayout] = []
    ) {
        self.singles = singles
        self.axisLayouts = axisLayouts
        self.dimensionLayouts = dimensionLayouts
        self.futureLayouts = futureLayouts
    }
    
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
