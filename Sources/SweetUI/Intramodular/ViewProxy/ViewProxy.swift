//
//  ViewProxy.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

import UICocoa

public struct ViewProxy<Base: UIView> {
    
    /// Stored view, managed by the DSL.
    public let base: Base
    
    public var layout: LayoutProxy<Base, LayoutProxySteps.Initial> {
        .init(base, childLayoutConfigurators: [self])
    }
    
    internal var childLayoutConfigurators: [FutureLayoutConfigurator]
    
    /// Initializes and returns a newly allocated dsl object with specified managed view.
    ///
    /// - Parameter content: Closure, that specifies managed view.
    init(_ base: Base, childLayoutConfigurators: [FutureLayoutConfigurator] = []) {
        self.base = base
        self.childLayoutConfigurators = childLayoutConfigurators
    }
    
}

extension ViewProxy: UIViewProvider {
    public var view: UIView { base }
}

extension ViewProxy: FutureLayoutConfigurator {
    func configureLayout() {
        childLayoutConfigurators.forEach {
            $0.configureLayout()
        }
    }
}

public extension ViewProxy {
    
    /// Provides a closure with the caller instance as a parameter.
    ///
    /// Use it to modify caller instance.
    ///
    /// Override this method in custom UIView subclasses with your class modification parameter:
    ///
    /// ```(Class)->Void```
    ///
    /// to provide more convinient API.
    ///
    /// - Parameter modification: Closure that takes the caller instance as a parameter,
    /// - Returns: Caller instance.
    @discardableResult
    func modified(by modification: (Base) -> Void) -> Self {
        modification(base)
        return self
    }
    
    /// Adds a new SUITapGestureRecognizer to the view.
    ///
    /// - Parameter action: Action to execute on user's tap.
    /// - Returns: Caller instance.
    @discardableResult
    func onTapGesture(perform action: @escaping (Base) -> Void) -> Self {
        onTapGesture { [weak base] in base.map(action) }
    }
    
    /// Adds a new SUITapGestureRecognizer to the view.
    ///
    /// - Parameter action: Action to execute on user's tap.
    /// - Returns: Caller instance.
    @discardableResult
    func onTapGesture(perform action: @escaping () -> Void) -> Self {
        gestureRecognizer(UITapGestureRecognizer(.init(action: action)))
    }
    
}

//MARK: - Other
public extension ViewProxy {
    
    /// Links the outer variable to the caller instance.
    ///
    /// Does nothing if caller instance is not castable to a variable type,
    /// otherwise erases outer variable and places the caller instance address into it.
    ///
    /// - Parameter ref: Outer variable, that will be linked to the caller instance.
    /// - Returns: Caller instance.
    @discardableResult
    func link<T: UIView>(to ref: inout T?) -> Self {
        modified{ if let view = $0 as? T { ref = view }}
    }
    
    /// Specifies if the view is interactive.
    ///
    /// The same as `.isUserInteractionEnabled = enabled`, but fits SweetUI's chainable API.
    /// - Parameter enabled: New value for the property.
    /// - Returns: Caller instance.
    @discardableResult
    func interaction(enabled: Bool) -> Self {
        modified{ $0.isUserInteractionEnabled = enabled }
    }
    
    /// Hides the caller instance.
    ///
    /// The same as `.isHidden = true`, but fits SweetUI's chainable API.
    /// - Returns: Caller instance.
    @discardableResult
    func hide() -> Self {
        modified{ $0.isHidden = true }
    }
    
    /// Shows the caller instance.
    ///
    /// The same as `.isHidden = false`, but fits SweetUI's chainable API.
    /// - Returns: Caller instance.
    @discardableResult
    func show() -> Self {
        modified{ $0.isHidden = false }
    }
    
}

// MARK: - Colors
public extension ViewProxy {
    
    /// Sets the opacity of the caller instance by changing it's alpha value.
    ///
    /// - Parameter value: A new alpha value of the caller instance.
    /// - Returns: Caller instance.
    @discardableResult
    func alpha(_ value: CGFloat) -> Self {
        modified { $0.alpha = value }
    }
    
    /// Sets the background color of the caller instance.
    ///
    /// - Parameter color: A new backgroundColor of the caller instance.
    /// - Returns: Caller instance.
    @discardableResult
    func background(color: UIColor?) -> Self {
        modified { $0.backgroundColor = color }
    }
    
    /// Sets the tint color of the caller instance.
    ///
    /// - Parameter color: A new tintColor of the caller instance.
    /// - Returns: Caller instance.
    @discardableResult
    func tint(color: UIColor) -> Self {
        modified { $0.tintColor = color }
    }
    
}

// MARK: - Corners
public extension ViewProxy {
    
    /// Sets the corner radius of the view by masking specified corners.
    ///
    /// - Parameter value: A new cornerRadius of the caller instance's layer.
    /// - Returns: Caller instance.
    @discardableResult
    func cornerRadius(_ value: CGFloat) -> Self {
        modified {
            $0.layer.cornerRadius = value
            if #available(iOS 11.0, *) {
                $0.layer.maskedCorners = .init(.all)
            }
        }
    }
    
    /// Sets the corner radius of the view by masking specified corners.
    ///
    /// - Parameter value: A new cornerRadius of the caller instance's layer.
    /// - Parameter corners: Set of corners to create a new maskedCorners value of the caller instance's layer.
    /// - Returns: Caller instance.
    @available(iOS 11.0, *)
    @discardableResult
    func cornerRadius(_ value: CGFloat, corners: CACornerMask.Corner...) -> Self {
        cornerRadius(value, corners: Set(corners))
    }
    
    /// Sets the corner radius of the view by masking specified corners.
    ///
    /// - Parameter value: A new cornerRadius of the caller instance's layer.
    /// - Parameter corners: Set of corners to create a new maskedCorners value of the caller instance's layer. (`.all` by default).
    /// - Returns: Caller instance.
    @available(iOS 11.0, *)
    @discardableResult
    func cornerRadius(_ value: CGFloat, corners: CACornerMask.Corners) -> Self {
        modified {
            $0.layer.cornerRadius = value
            $0.layer.maskedCorners = .init(corners)
        }
    }
    
}

// MARK: - Frame
public extension ViewProxy {
    
    /// Sets the frame of the view.
    ///
    /// - Parameter x: View's frame.origin.x new value.
    /// - Parameter y: View's frame.origin.y new value.
    /// - Parameter width: View's frame.size.width new value.
    /// - Parameter height: View's frame.size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func frame(x: Int, y: Int, width: Int, height: Int) -> Self {
        frame(.init(x: x, y: y, width: width, height: height))
    }
    
    /// Sets the frame of the view.
    ///
    /// - Parameter x: View's frame.origin.x new value.
    /// - Parameter y: View's frame.origin.y new value.
    /// - Parameter width: View's frame.size.width new value.
    /// - Parameter height: View's frame.size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func frame(x: Double, y: Double, width: Double, height: Double) -> Self {
        frame(.init(x: x, y: y, width: width, height: height))
    }
    
    /// Sets the frame of the view.
    ///
    /// - Parameter x: View's frame.origin.x new value.
    /// - Parameter y: View's frame.origin.y new value.
    /// - Parameter width: View's frame.size.width new value.
    /// - Parameter height: View's frame.size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func frame(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> Self {
        frame(.init(x: x, y: y, width: width, height: height))
    }
    
    /// Sets the frame of the view.
    ///
    /// - Parameter origin: View's frame.origin new value.
    /// - Parameter size: View's frame.size new value.
    /// - Returns: Caller instance.
    @discardableResult
    func frame(origin: CGPoint, size: CGSize) -> Self {
        frame(.init(origin: origin, size: size))
    }
    
    /// Sets the frame of the view.
    ///
    /// - Parameter rect: New value for view's frame.
    /// - Returns: Caller instance.
    @discardableResult
    func frame(_ rect: CGRect) -> Self {
        modified { $0.frame = rect }
    }
    
}

// MARK: - Bounds
public extension ViewProxy {
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter x: View's bounds.origin.x new value.
    /// - Parameter y: View's bounds.origin.y new value.
    /// - Parameter width: View's bounds.size.width new value.
    /// - Parameter height: View's bounds.size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func bounds(x: Int, y: Int, width: Int, height: Int) -> Self {
        bounds(.init(x: x, y: y, width: width, height: height))
    }
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter x: View's bounds.origin.x new value.
    /// - Parameter y: View's bounds.origin.y new value.
    /// - Parameter width: View's bounds.size.width new value.
    /// - Parameter height: View's bounds.size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func bounds(x: Double, y: Double, width: Double, height: Double) -> Self {
        bounds(.init(x: x, y: y, width: width, height: height))
    }
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter x: View's bounds.origin.x new value.
    /// - Parameter y: View's bounds.origin.y new value.
    /// - Parameter width: View's bounds.size.width new value.
    /// - Parameter height: View's bounds.size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func bounds(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> Self {
        bounds(.init(x: x, y: y, width: width, height: height))
    }
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter origin: View's bounds.origin new value.
    /// - Parameter size: View's bounds.size new value.
    /// - Returns: Caller instance.
    @discardableResult
    func bounds(origin: CGPoint, size: CGSize) -> Self {
        bounds(.init(origin: origin, size: size))
    }
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter rect: New value for view's bounds.
    /// - Returns: Caller instance.
    @discardableResult
    func bounds(_ rect: CGRect) -> Self {
        modified { $0.bounds = rect }
    }
    
}

// MARK: - Origin
public extension ViewProxy {
    
    /// Sets the origin of the view.
    ///
    /// - Parameter x: View's origin.x new value.
    /// - Parameter y: View's origin.y new value.
    /// - Returns: Caller instance.
    @discardableResult
    func origin(x: Int, y: Int) -> Self {
        origin(.init(x: x, y: y))
    }
    
    /// Sets the origin of the view.
    ///
    /// - Parameter x: View's origin.x new value.
    /// - Parameter y: View's origin.y new value.
    /// - Returns: Caller instance.
    @discardableResult
    func origin(x: Double, y: Double) -> Self {
        origin(.init(x: x, y: y))
    }
    
    /// Sets the origin of the view.
    ///
    /// - Parameter x: View's origin.x new value.
    /// - Parameter y: View's origin.y new value.
    /// - Returns: Caller instance.
    @discardableResult
    func origin(x: CGFloat, y: CGFloat) -> Self {
        origin(.init(x: x, y: y))
    }
    
    /// Sets the origin of the view.
    ///
    /// - Parameter point: New value for view's origin.
    /// - Returns: Caller instance.
    @discardableResult
    func origin(_ point: CGPoint) -> Self {
        modified { $0.frame.origin = point }
    }
    
}

// MARK: - Size
public extension ViewProxy {
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter width: View's size.width new value.
    /// - Parameter height: View's size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func size(width: Int, height: Int) -> Self {
        size(.init(width: width, height: height))
    }
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter width: View's size.width new value.
    /// - Parameter height: View's size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func size(width: Double, height: Double) -> Self {
        size(.init(width: width, height: height))
    }
    
    /// Sets the bounds of the view.
    ///
    /// - Parameter width: View's size.width new value.
    /// - Parameter height: View's size.height new value.
    /// - Returns: Caller instance.
    @discardableResult
    func size(width: CGFloat, height: CGFloat) -> Self {
        size(.init(width: width, height: height))
    }
    
    /// Sets the size of the view.
    ///
    /// - Parameter size: New value for view's size.
    /// - Returns: Caller instance.
    @discardableResult
    func size(_ size: CGSize) -> Self {
        modified { $0.bounds.size = size }
    }
    
}

// MARK: - Center
public extension ViewProxy {
    
    /// Sets the center of the view.
    ///
    /// - Parameter x: View's center.x new value.
    /// - Parameter y: View's center.y new value.
    /// - Returns: Caller instance.
    @discardableResult
    func center(x: Int, y: Int) -> Self {
        center(.init(x: x, y: y))
    }
    
    /// Sets the center of the view.
    ///
    /// - Parameter x: View's center.x new value.
    /// - Parameter y: View's center.y new value.
    /// - Returns: Caller instance.
    @discardableResult
    func center(x: Double, y: Double) -> Self {
        center(.init(x: x, y: y))
    }
    
    /// Sets the center of the view.
    ///
    /// - Parameter x: View's center.x new value.
    /// - Parameter y: View's center.y new value.
    /// - Returns: Caller instance.
    @discardableResult
    func center(x: CGFloat, y: CGFloat) -> Self {
        center(.init(x: x, y: y))
    }
    
    /// Sets the center of the view.
    ///
    /// - Parameter point: New value for view's center.
    /// - Returns: Caller instance.
    @discardableResult
    func center(_ point: CGPoint) -> Self {
        modified { $0.center = point }
    }
    
}

// MARK: - Gesture recognizers
public extension ViewProxy {
    
    /// Adds a new UITapGestureRecognizer to the view.
    ///
    /// - Parameter target: Action's selector target.
    /// - Parameter action: Selector for gesture recognizer.
    /// - Returns: Caller instance.
    @discardableResult
    func tapRecognizer(_ target: UIActionTarget) -> Self {
        modified {
            $0.ui.gestureRecognizer(
                UITapGestureRecognizer(
                    target: target,
                    action: target.selector
                )
            )
        }
    }
    
    /// Adds a new UIPanGestureRecognizer to the view.
    ///
    /// - Parameter target: Action's selector target.
    /// - Parameter action: Selector for gesture recognizer.
    /// - Returns: Caller instance.
    @discardableResult
    func panRecognizer(_ target: UIActionTarget) -> Self {
        modified {
            $0.ui.gestureRecognizer(
                UIPanGestureRecognizer(
                    target: target,
                    action: target.selector
                )
            )
        }
    }
    
    /// Adds a new UIPressGestureRecognizer to the view.
    ///
    /// - Parameter target: Action's selector target.
    /// - Parameter action: Selector for gesture recognizer.
    /// - Returns: Caller instance.
    @discardableResult
    func pressRecognizer(_ target: UIActionTarget) -> Self {
        modified {
            $0.ui.gestureRecognizer(
                UILongPressGestureRecognizer(
                    target: target,
                    action: target.selector
                )
            )
        }
    }
    
    /// Adds a new UISwipeGestureRecognizer to the view.
    ///
    /// - Parameter target: Action's selector target.
    /// - Parameter action: Selector for gesture recognizer.
    /// - Returns: Caller instance.
    @discardableResult
    func swipeRecognizer(_ target: UIActionTarget) -> Self {
        modified {
            $0.ui.gestureRecognizer(
                UISwipeGestureRecognizer(
                    target: target,
                    action: target.selector
                )
            )
        }
    }
    
    /// Adds a new UIPinchGestureRecognizer to the view.
    ///
    /// - Parameter target: Action's selector target.
    /// - Parameter action: Selector for gesture recognizer.
    /// - Returns: Caller instance.
    @discardableResult
    func pinchRecognizer(_ target: UIActionTarget) -> Self {
        modified {
            $0.ui.gestureRecognizer(
                UIPinchGestureRecognizer(
                    target: target,
                    action: target.selector
                )
            )
        }
    }
    
    /// Adds a new UIRotationGestureRecognizer to the view.
    ///
    /// - Parameter target: Action's selector target.
    /// - Parameter action: Selector for gesture recognizer.
    /// - Returns: Caller instance.
    @discardableResult
    func rotationRecognizer(_ target: UIActionTarget) -> Self {
        modified {
            $0.ui.gestureRecognizer(
                UIRotationGestureRecognizer(
                    target: target,
                    action: target.selector
                )
            )
        }
    }
    
    /// Adds a new UIGestureRecognizer to the view.
    ///
    /// - Parameter recognizer: Gesture recognizer, that will be added to DSL's view.
    /// - Returns: Caller instance.
    @discardableResult
    func gestureRecognizer(_ recognizer: UIGestureRecognizer) -> Self {
        modified { $0.addGestureRecognizer(recognizer) }
    }
    
    /// Adds a new SUITapGestureRecognizer to the view.
    ///
    /// - Parameter action: Action to execute on user's tap.
    /// - Returns: Caller instance.
    @discardableResult
    func onTapGesture(perform action: @escaping (UITapGestureRecognizer) -> Void) -> Self {
        gestureRecognizer(
            UITapGestureRecognizer(
                handler: {
                    let a = $0
                    print(a.numberOfTapsRequired)
                    
                }
            )
        )
    }
    
}

// MARK: - Subviews
public extension ViewProxy {
    
    func body(@UIViewBuilder content: UIViewBuilder.Content) -> Self {
        modified { base in
            base.setBody(content().view)
        }
    }
    
    /// Adds subviews to a view.
    ///
    /// Wraps provided subviews in a container view, than adds a container view to DSL's view.
    ///
    /// - Parameter content: Multiline closure, which provides one or many child views.
    /// - Returns: Caller instance.
    @discardableResult
    func add(@UIViewBuilder content: UIViewBuilder.Content) -> Self {
        modified {
            $0.ui.add(content())
        }
    }
    
    /// Adds subviews to a view.
    ///
    /// Wraps provided subviews in a container view, than adds a container view to DSL's view.
    ///
    /// - Parameter content: Multiline closure, which provides one or many child views.
    /// - Parameter index: Index of a new subview.
    /// - Returns: Caller instance.
    @discardableResult
    func add(@UIViewBuilder content: UIViewBuilder.Content, at index: Int) -> Self {
        add(content(), at: index)
    }
    
    /// Adds subviews to a view.
    ///
    /// Wraps provided subviews in a container view, than adds a container view to DSL's view.
    ///
    /// - Parameter content: Multiline closure, which provides one or many child views.
    /// - Parameter subview: DSL view's subview, that will be below the container view.
    /// - Returns: Caller instance.
    @discardableResult
    func add(@UIViewBuilder content: UIViewBuilder.Content, above subview: UIView) -> Self {
        add(content(), above: subview)
    }
    
    /// Adds subviews to a view.
    ///
    /// Wraps provided subviews in a container view, than adds a container view to DSL's view.
    ///
    /// - Parameter content: Multiline closure, which provides one or many child views.
    /// - Parameter subview: DSL view's subview, that will be above the container view.
    /// - Returns: Caller instance.
    @discardableResult
    func add(@UIViewBuilder content: UIViewBuilder.Content, below subview: UIView) -> Self {
        add(content(), below: subview)
    }
    
    /// Adds subview to a view.
    ///
    /// - Parameter view: A new subview.
    /// - Returns: Caller instance.
    @discardableResult
    func add(_ provider: UIViewProvider) -> Self {
        modified {
            $0.addSubview(provider.view)
            (provider as? FutureLayoutConfigurator)?.configureLayout()
        }
    }
    
    /// Adds subview to a view.
    ///
    /// - Parameter view: A new subview.
    /// - Parameter index: Index of a new subview,.
    /// - Returns: Caller instance.
    @discardableResult
    func add(_ provider: UIViewProvider, at index: Int) -> Self {
        modified {
            $0.insertSubview(provider.view, at: index)
            (provider as? FutureLayoutConfigurator)?.configureLayout()
        }
    }
    
    /// Adds subview to a view.
    ///
    /// - Parameter view: A new subview.
    /// - Parameter subview: DSL view's subview, that will be below the view you add.
    /// - Returns: Caller instance.
    @discardableResult
    func add(_ provider: UIViewProvider, above subview: UIView) -> Self {
        modified {
            $0.insertSubview(provider.view, aboveSubview: subview)
            (provider as? FutureLayoutConfigurator)?.configureLayout()
        }
    }
    
    /// Adds subview to a view.
    ///
    /// - Parameter view: A new subview.
    /// - Parameter subview: DSL view's subview, that will be above the view you add.
    /// - Returns: Caller instance.
    @discardableResult
    func add(_ provider: UIViewProvider, below subview: UIView) -> Self {
        modified {
            $0.insertSubview(view, belowSubview: subview)
            (provider as? FutureLayoutConfigurator)?.configureLayout()
        }
    }
    
    /// Removes subview from a view.
    ///
    /// Subview will be removed only if it's in the DSL's view hierarchy
    ///
    /// - Parameter view: A subview to remove.
    /// - Returns: Caller instance.
    @discardableResult
    func remove(_ view: UIView) -> Self {
        modified {
            while $0.superview != nil {
                if $0 === view.superview {
                    view.removeFromSuperview()
                    return
                }
            }
        }
    }
    
    /// Removes subview from a view.
    ///
    /// Subview will be removed only if it's in the DSL's view hierarchy
    ///
    /// - Parameter view: A subview, above the target view to remove.
    /// - Returns: Caller instance.
    @discardableResult
    func removeView(below view: UIView) -> Self {
        guard let index = view.subviews.firstIndex(where: { $0 === view }) else { return self }
        return removeView(at: index - 1)
    }
    
    /// Removes subview from a view.
    ///
    /// Subview will be removed only if it's in the DSL's view hierarchy
    ///
    /// - Parameter view: A subview, below the target view to remove.
    /// - Returns: Caller instance.
    @discardableResult
    func removeView(above view: UIView) -> Self {
        guard let index = view.subviews.firstIndex(where: { $0 === view }) else { return self }
        return removeView(at: index + 1)
    }
    
    /// Removes subview from a view.
    ///
    /// Subview will be removed only if it's in the DSL's view hierarchy
    ///
    /// - Parameter index: Index of the DSL's view subview to remove.
    /// - Returns: Caller instance.
    @discardableResult
    func removeView(at index: Int) -> Self {
        guard let view = view.subviews[safe: index] else { return self }
        return remove(view)
    }
    
    /// Removes all of subviews from the DSL's view hierarchy
    ///
    /// - Returns: Caller instance. 
    @discardableResult
    func removeSubviews() -> Self {
        modified { $0.subviews.forEach{ $0.removeFromSuperview() } }
    }
    
}

