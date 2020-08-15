//
//  UIColor+.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

// MARK: - GradientDirection
public extension UIColor {
    
    /// Направление градиента.
    enum GradientDirection {
        case horizontal
        case vertical
        case topLeftBottomRight
        case bottomLeftTopRight

        /// Начальная координата для градиента.
        var startPoint: CGPoint {
            switch self {
            case .horizontal:
                return .init(x: 0, y: 0.5)
            case .vertical:
                return .init(x: 0.5, y: 0)
            case .topLeftBottomRight:
                return .init(x: 0, y: 0)
            case .bottomLeftTopRight:
                return .init(x: 0, y: 1)
            }
        }
        
        /// Конечная координата для градиента.
        var endPoint: CGPoint {
            switch self {
            case .horizontal:
                return .init(x: 1, y: 0.5)
            case .vertical:
                return .init(x: 0.5, y: 1)
            case .topLeftBottomRight:
                return .init(x: 1, y: 1)
            case .bottomLeftTopRight:
                return .init(x: 1, y: 0)
            }
        }
    }
    
}
