// Source: https://gist.github.com/maximkrouk/6287fb56321a21e8180d5fe044e642e4

/// A path that supports embedding a value in a root and attempting to extract a root's embedded
/// value.
///
/// This type defines key path-like semantics for enum cases.
struct FunctionalKeyPath<Root, Value> {
    private let _embed: (Value, Root) -> Root
    private let _extract: (Root) -> Value
    
    /// Creates a case path with a pair of functions.
    ///
    /// - Parameters:
    ///   - embed: A function that always succeeds in embedding a value in a root.
    ///   - extract: A function that can optionally fail in extracting a value from a root.
    public init(embed: @escaping (Value, Root) -> Root, extract: @escaping (Root) -> Value) {
        self._embed = embed
        self._extract = extract
    }
    
    public init(_ keyPath: WritableKeyPath<Root, Value>) {
        self.init(
            embed: { value, root in
                var root = root
                root[keyPath: keyPath] = value
                return root
            }, extract: { root in
                root[keyPath: keyPath]
            }
        )
    }
    
    public init(_ keyPath: ReferenceWritableKeyPath<Root, Value>) {
        self.init(
            embed: { value, root in
                root[keyPath: keyPath] = value
                return root
            }, extract: { root in
                root[keyPath: keyPath]
            }
        )
    }
    
    /// Returns a root by embedding a value.
    ///
    /// - Parameter value: A value to embed.
    /// - Returns: A root that embeds `value`.
    public func embed(_ value: Value, in root: Root) -> Root {
        self._embed(value, root)
    }
    
    /// Attempts to extract a value from a root.
    ///
    /// - Parameter root: A root to extract from.
    /// - Returns: A value iff it can be extracted from the given root, otherwise `nil`.
    public func extract(from root: Root) -> Value {
        self._extract(root)
    }
    
    /// Returns a new case path created by appending the given case path to this one.
    ///
    /// Use this method to extend this case path to the value type of another case path.
    ///
    /// - Parameter path: The case path to append.
    /// - Returns: A case path from the root of this case path to the value type of `path`.
    public func appending<AppendedValue>(path: FunctionalKeyPath<Value, AppendedValue>) -> FunctionalKeyPath<Root, AppendedValue> {
        FunctionalKeyPath<Root, AppendedValue>(
            embed: { appendedValue, root in
                self.embed(
                    path.embed(
                        appendedValue,
                        in: self.extract(from: root)
                    ),
                    in: root
                )
            },
            extract: { root in
                path.extract(
                    from: self.extract(from: root)
                )
            }
        )
    }
}