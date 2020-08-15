//
//  UIImage+.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

#if os(iOS)

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

#else
#warning("https://github.com/MakeupStudio/iMage can provide a solution")
#endif
