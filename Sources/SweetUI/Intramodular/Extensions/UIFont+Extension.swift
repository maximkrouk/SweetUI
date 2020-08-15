//
//  UIFont+Extension.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UIKit

public extension UIFont {
    
    static func system(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        .systemFont(ofSize: size, weight: weight)
    }
    
}
