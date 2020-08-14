//
//  UIImage+Extension.swift
//  Pods-SweetUI_Example
//
//  Created by Maxim Krouk on 10/15/19.
//

public extension UIImage {
    
    static func render(from color: UIColor = .clear, size: CGSize) -> UIImage {
        let layer = CALayer()
        layer.backgroundColor = color.cgColor
        layer.frame.size = size
        return UIGraphicsImageRenderer(bounds: layer.frame).image {
            layer.render(in: $0.cgContext)
        }
    }
    
}
