//
//  Builder.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

@dynamicMemberLookup
public struct Builder<T> {
    private var initial: T
    private var transform: (T) -> T = { $0 }
    
    @inlinable
    public init(_ initialize: () -> T) { self.init(initialize()) }
    
    public init(_ initial: T) { self.initial = initial }
    
    @inlinable
    public func setIf<Value>(_ condition: Bool, _ keyPath: WritableKeyPath<T, Value>, _ value: Value) -> Self {
        if condition { return self.set(keyPath, value) }
        else { return self }
    }
    
    @inlinable
    public func setIf(_ condition: Bool, _ transform: @escaping (inout T) -> Void) -> Self {
        if condition { return self.set(transform) }
        else { return self }
    }
    
    @inlinable
    public func set<Value>(_ keyPath: WritableKeyPath<T, Value>, _ value: Value) -> Self {
        self.set { object in
            object[keyPath: keyPath] = value
        }
    }
    
    public func set(_ transform: @escaping (inout T) -> Void) -> Self {
        modification(of: self) { _self in
            _self.transform = { object in
                modification(of: self.transform(object), with: transform)
            }
        }
    }
    
    public func build() -> T { transform(initial) }
    
    public struct BuildBlock<Value> {
        var builder: Builder
        var keyPath: WritableKeyPath<T, Value>
        func callAsFunction(_ value: Value) -> Builder {
            builder.set(keyPath, value)
        }
    }
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<T, Value>) -> BuildBlock<Value> {
        BuildBlock(builder: self, keyPath: keyPath)
    }
    
}
