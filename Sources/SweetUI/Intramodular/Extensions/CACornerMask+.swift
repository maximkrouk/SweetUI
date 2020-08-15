//
//  CACornerMask+.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

public extension CACornerMask {
    /// Set of corners.
    typealias Corners = Set<Corner>
    
    /// Corner type.
    enum Corner: UInt {
        case topLeft = 1
        case topRight = 2
        case bottomLeft = 4
        case bottomRight = 8
    }
    
}

public extension Array where Element == CACornerMask.Corner {
    
    var cornerMask: CACornerMask { Set(self).cornerMask }
    
}

public extension Set where Element == CACornerMask.Corner {
    
    /// Coner mask, initialized by set elements.
    var cornerMask: CACornerMask { CACornerMask(rawValue: reduce(0, { $0 + $1.rawValue })) }
    
    /// The same as [.topLeft, .topRight]
    static var top: Set<Element> { [.topLeft, .topRight] }
    
    /// The same as [.bottomLeft, .bottomRight]
    static var bottom: Set<Element> { [.bottomLeft, .bottomRight] }
    
    /// The same as [.topLeft, .bottomLeft]
    static var left: Set<Element> { [.topLeft, .bottomLeft] }
    
    /// The same as [.topRight, .bottomRight]
    static var right: Set<Element> { [.topRight, .bottomRight] }
    
    /// The same as [.topLeft, .bottomRight]
    static var tlbr: Set<Element> { [.topLeft, .bottomRight] }
    
    /// The same as [.topRight, .bottomLeft]
    static var trbl: Set<Element> { [.topRight, .bottomLeft] }
    
    /// The same as [.topLeft, .topRight, .bottomLeft, .bottomRight]
    static var all: Set<Element> { [.topLeft, .topRight, .bottomLeft, .bottomRight] }
    
    /// An empty array
    static var none: Set<Element> { [] }
    
    /// Corner mask getter.
    ///
    /// - Parameter corners: Specifies corners, that will be masked.
    /// - Returns: Coner mask, initialized by corners.
    static func mask(_ corners: Element...) -> CACornerMask { corners.cornerMask }
    
    /// Corner mask getter.
    ///
    /// - Parameter corners: Specifies corners, that will be masked.
    /// - Returns: Coner mask, initialized by corners.
    static func mask(_ corners: Set<Element>) -> CACornerMask { corners.cornerMask }
    
    /// - Parameter corners: Specifies corners, that will be excluded from the set.
    /// - Returns: Coner mask, initialized by corners.
    static func excluding(_ corners: Element...) -> Set<Element> { excluding(Set(corners)) }
    
    /// - Parameter corners: Specifies corners, that will be excluded from the set.
    /// - Returns: Coner mask, initialized by corners.
    static func excluding(_ corners: Set<Element>) -> Set<Element> { all.filter{ !corners.contains($0) }}
    
}

public extension CACornerMask {
    
    /// Initializes and returns a newly allocated cornerMask object.
    ///
    /// - Parameter corners: Specifies corners, that will be masked.
    init(_ corners: Corner...) { self = corners.cornerMask }
    
    /// Initializes and returns a newly allocated cornerMask object.
    ///
    /// - Parameter corners: Specifies corners, that will be masked.
    init(_ corners: Corners ) { self = corners.cornerMask }
    
}
