//
//  File.swift
//  
//
//  Created by Maxim Krouk on 8/14/20.
//

import UIKit

public final class UIActionTarget {
    private static var cache: [ObjectIdentifier: UIActionTarget] = [:]
    private var action: () -> Void
    
    public func callAsFunction() { action() }
    
    public convenience init<Environment>(environment: @escaping @autoclosure () -> Environment, action: @escaping (Environment) -> Void) {
        self.init(action: { action(environment()) })
    }
    
    public init(action: @escaping () -> Void = {}) {
        self.action = action
        self.retain()
    }
    
    public func setAction<Environment>(
        environment: @escaping @autoclosure () -> Environment,
        action: @escaping (Environment) -> Void
    ) {
        setAction { action(environment()) }
    }
    
    public func setAction(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    public var target: UIActionTarget { self }
    public var selector: ObjectiveC.Selector { #selector(_action) }
    @objc private func _action() { action() }
    
    public func retain() { Self.cache[.init(self)] = self }
    public func release() { Self.cache[.init(self)] = nil }
}
