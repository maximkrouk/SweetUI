// Source: https://gist.github.com/maximkrouk/eede7171952e044492c1fa57291bcf94

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
    
    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Object, T>) -> CallableBuildBlock<T> {
        CallableBuildBlock(
            base: BuildBlock(
                builder: self,
                keyPath: .init(keyPath)
            )
        )
    }
    
    public subscript<T>(dynamicMember keyPath: ReferenceWritableKeyPath<Object, T>) -> CallableBuildBlock<T>
    where T: AnyObject {
        CallableBuildBlock(
            base: BuildBlock(
                builder: self,
                keyPath: .init(keyPath)
            )
        )
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Object, T>) -> BuildBlock<T>
    where T: AnyObject {
        BuildBlock<T>(
            builder: self,
            keyPath: FunctionalKeyPath(
                embed: { value, root in root  },
                extract: { root in root[keyPath: keyPath] }
            )
        )
    }
    
}

extension Builder where Object: AnyObject {
    public func apply() { _ = build() }
}
