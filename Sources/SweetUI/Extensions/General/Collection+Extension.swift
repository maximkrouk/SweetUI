//
//  Collection+Extension.swift
//  SweetUI
//
//  Created by Maxim on 7/17/19.
//

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
    
}

extension Collection {
    /// - Returns: Number of elements in collection, counting from 0.
    var lastIndex: Int? { count > 0 ? count - 1 : .none }
}
