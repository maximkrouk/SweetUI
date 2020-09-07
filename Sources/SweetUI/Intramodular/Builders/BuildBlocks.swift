// Source: https://gist.github.com/maximkrouk/eede7171952e044492c1fa57291bcf94

import Foundation

extension Builder {
    @dynamicMemberLookup
    public struct CallableBuildBlock<Value> {
        var base: BuildBlock<Value>
        
        public func callAsFunction(_ value: Value) -> Builder<Object> {
            base.builder.set { object in
                object = base.keyPath.embed(value, in: object)
            }
        }
        
        public subscript<T>(dynamicMember keyPath: ReferenceWritableKeyPath<Value, T>) -> CallableBuildBlock<T>
        where Value: AnyObject { base[dynamicMember: keyPath] }
        
        public subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> CallableBuildBlock<T> {
            base[dynamicMember: keyPath]
        }
        
        public subscript<U, T>(dynamicMember keyPath: WritableKeyPath<U, T>) -> CallableBuildBlock<T?>
        where Value == Optional<U> { base[dynamicMember: keyPath] }
        
        
        public subscript<T>(dynamicMember keyPath: KeyPath<Object, T>) -> BuildBlock<T>
        where T: AnyObject { base[dynamicMember: keyPath] }
    }
    
    @dynamicMemberLookup
    public struct BuildBlock<Value> {
        internal init(builder: Builder<Object>, keyPath: FunctionalKeyPath<Object, Value>) {
            self.builder = builder
            self.keyPath = keyPath
        }
        
        var builder: Builder<Object>
        var keyPath: FunctionalKeyPath<Object, Value>
        
        public subscript<T>(dynamicMember keyPath: ReferenceWritableKeyPath<Value, T>) -> CallableBuildBlock<T>
        where Value: AnyObject {
            CallableBuildBlock<T>(
                base: BuildBlock<T>(
                    builder: builder,
                    keyPath: self.keyPath.appending(
                        path: FunctionalKeyPath<Value, T>(keyPath)
                    )
                )
            )
        }
        
        public subscript<T>(dynamicMember keyPath: WritableKeyPath<Value, T>) -> CallableBuildBlock<T> {
            CallableBuildBlock<T>(
                base: BuildBlock<T>(
                    builder: builder,
                    keyPath: self.keyPath.appending(
                        path: FunctionalKeyPath<Value, T>(keyPath)
                    )
                )
            )
        }
        
        public subscript<U, T>(dynamicMember keyPath: WritableKeyPath<U, T>) -> CallableBuildBlock<T?>
        where Value == Optional<U> {
            CallableBuildBlock<T?>(
                base: BuildBlock<T?>(
                    builder: builder,
                    keyPath: self.keyPath.appending(
                        path: FunctionalKeyPath<U?, T?>(
                            embed: { value, root in
                                modification(of: root) { root in
                                    value.map { root?[keyPath: keyPath] = $0 }
                                }
                            },
                            extract: { root in
                                root?[keyPath: keyPath]
                            }
                        )
                    )
                )
            )
        }
        
        public subscript<T>(dynamicMember keyPath: KeyPath<Object, T>) -> BuildBlock<T>
        where T: AnyObject {
            BuildBlock<T>(
                builder: builder,
                keyPath: .init(
                    embed: { value, root in root },
                    extract: { root in root[keyPath: keyPath] }
                )
            )
        }
    }
}
