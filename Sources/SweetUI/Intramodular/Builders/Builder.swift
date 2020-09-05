//
//  Builder.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

@dynamicMemberLookup
public struct Builder<Object> {
    private var _build: () -> Object
    public func build() -> Object { _build() }
    
    public init(_ initialValue: Object) { self._build = { initialValue } }
    
    @inlinable
    public func setIf<Value>(_ condition: Bool, _ keyPath: WritableKeyPath<Object, Value>, _ value: @autoclosure () -> Value) -> Self {
        if condition { return self.set(keyPath, value()) }
        else { return self }
    }
    
    @inlinable
    public func setIf(_ condition: Bool, _ transform: @escaping (inout Object) -> Void) -> Self {
        if condition { return self.set(transform) }
        else { return self }
    }
    
    @inlinable
    public func set<Value>(_ keyPath: WritableKeyPath<Object, Value>, _ value: Value) -> Self {
        self.set { object in
            object[keyPath: keyPath] = value
        }
    }
    
    public func set(_ transform: @escaping (inout Object) -> Void) -> Self {
        modification(of: self) { _self in
            _self._build = {
                modification(of: build(), with: transform)
            }
        }
    }
    
    @dynamicMemberLookup
    public struct BuildBlock<Value> {
        var builder: Builder<Object>
        var keyPath: WritableKeyPath<Object, Value>
        public func callAsFunction(_ value: Value) -> Builder<Object> {
            builder.set(keyPath, value)
        }
        
        public subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> BuildBlock<T> {
            BuildBlock<T>(builder: builder, keyPath: self.keyPath.appending(path: keyPath))
        }
    }
    
    public subscript<Value>(dynamicMember keyPath: WritableKeyPath<Object, Value>) -> BuildBlock<Value> {
        BuildBlock(builder: self, keyPath: keyPath)
    }
    
}
