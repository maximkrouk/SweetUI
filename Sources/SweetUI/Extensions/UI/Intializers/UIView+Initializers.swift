//
//  UIView+SweetUI.swift
//  Pods
//
//  Created by Maxim on 7/17/19.
//

// MARK: - DSL
extension UIView: ViewDSLProvidingView {}

//MARK: - Init
public extension UIView {
    
    /// Initializes and returns a newly allocated view object with specified subviews added.
    ///
    /// The new view object must be inserted into the view hierarchy of a window before it can be used.
    ///
    /// - Parameter content: Closure, that specifies subviews to be added to the view hierarcy after initialization.
    convenience init(@UIViewBuilder content: UIViewBuilder.Content) {
        self.init()
        self.ui.add(content: content)
    }
    
}
