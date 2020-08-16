import UIKit

public final class CAInfiniteKeyPathAnimation<Layer: CALayer, Value>: CABasicAnimation, CAKeyPathDrivenAnimation {
    
    public override init() {
        super.init()
        self.repeatCount = .infinity
        self.isCumulative = true
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.repeatCount = .infinity
        self.isCumulative = true
    }
    
    public convenience init(
        on layer: Layer,
        _ keyPath: Delegate.Target,
        from: Value,
        to: Value,
        duration: CFTimeInterval
    ) {
        self.init(on: layer, keyPath, duration: duration)
        self.fromValue = from
        self.toValue = to
    }
    
    public convenience init(
        on layer: Layer,
        _ keyPath: Delegate.Target,
        from: Value,
        by: Value,
        duration: CFTimeInterval
    ) {
        self.init(on: layer, keyPath, duration: duration)
        self.fromValue = from
        self.byValue = by
    }
    
    public func run() {
        guard let layer = _delegate?.layer, let path = _delegate?.keyPath
        else { return }
        layer.add(self, forKey: path.asString)
    }
    
}
