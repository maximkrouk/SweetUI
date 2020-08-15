//
//  Collection+Extension.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import Foundation

extension MutableCollection {
    /// Safely subscripts element from a collection.
    ///
    /// - Parameter index: Element identifier.
    /// - Returns: Element at index or nil
    subscript(safe index: Self.Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
    /// Safely subscripts element from a collection.
    ///
    /// - Parameter index: Element identifier.
    /// - Parameter default: Default value.
    /// - Returns: Element at index or default value.
    subscript(safe index: Self.Index, default defautValue: @autoclosure () -> Element) -> Element {
        indices.contains(index) ? self[index] : defautValue()
    }
    
    mutating func mutatingForEach(_ transform: (inout Element) -> Void) {
        self = inoutForEach(transform)
    }
    
    func inoutForEach(_ transform: (inout Element) -> Void) -> Self {
        var copy = self
        indices.forEach { index in
            var element = copy[index]
            transform(&element)
            copy[index] = element
        }
        return copy
    }
    
}

extension Collection {
    /// - Returns: Number of elements in collection, counting from 0.
    var lastIndex: Int? { count > 0 ? count - 1 : .none }
}
