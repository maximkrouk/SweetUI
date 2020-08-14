//
//  UIColor+Extension.swift
//  Pods-SweetUI_Example
//
//  Created by Maxim Krouk on 10/15/19.
//

public extension UIColor {
    
    /// Creates non-resizable UIColor wrapped gradient
    ///
    /// - Parameter colors: Array of colors.
    /// - Parameter direction: Direction of a gradient.
    /// - Parameter bounds: Bounds of a gradient.
    static func gradient(_ colors: [UIColor], _ direction: GradientDirection = .horizontal, bounds: CGRect) -> Self {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        
        return gradient(from: gradientLayer)
    }
    
    /// Creates non-resizable UIColor wrapped gradient
    ///
    /// - Parameter colors: Array of colors.
    /// - Parameter direction: Direction of a gradient.
    /// - Parameter bounds: Bounds of a gradient.
    static func gradient(_ colorMap: [NSNumber: UIColor], _ direction: GradientDirection = .horizontal, bounds: CGRect) -> Self {
        let colorSpec = colorMap.reduce(into: (locations: [NSNumber], colors: [CGColor])([],[])) { result, item in
            result.locations.append(item.key)
            result.colors.append(item.value.cgColor)
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colorSpec.colors
        gradientLayer.locations = colorSpec.locations
        gradientLayer.startPoint = direction.startPoint
        gradientLayer.endPoint = direction.endPoint
        
        return gradient(from: gradientLayer)
    }
    
    /// Renderes non-resizable UIColor wrapped gradient from CAGradientLayer
    ///
    /// - Parameter layer: Gradient layer to render
    static func gradient(from layer: CAGradientLayer) -> Self {
        return .init(patternImage: UIGraphicsImageRenderer(bounds: layer.frame).image {
            layer.render(in: $0.cgContext)
        })
    }
    
}

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
