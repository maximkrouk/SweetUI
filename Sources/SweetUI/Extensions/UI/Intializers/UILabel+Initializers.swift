//
//  UILabel+SweetUI.swift
//  Pods
//
//  Created by Maxim on 7/17/19.
//

// MARK: - Init
public extension UILabel {
    
    /// Initializes and returns a newly allocated label object with specified text, textAlignment, textColor and added subviews.
    ///
    /// The new view object must be inserted into the view hierarchy of a window before it can be used.
    ///
    /// - Parameter text: Text of the label.
    /// - Parameter alignment: Text alignment of the label.
    /// - Parameter color: Text color of the label.
    /// - Parameter content: Closure, that specifies subviews to be added to the view hierarcy after initialization.
    convenience init(text: String? = nil, alignment: NSTextAlignment = .left, color: UIColor = .black, @SweetUI.UIViewBuilder content: () -> UIView) {
        self.init(text: text, alignment: alignment, color: color)
        ui.add(content: content)
    }
    
    /// Initializes and returns a newly allocated label object with specified text, textAlignment, and color.
    ///
    /// The new view object must be inserted into the view hierarchy of a window before it can be used.
    ///
    /// - Parameter text: Text of the label.
    /// - Parameter alignment: Text alignment of the label.
    /// - Parameter color: Text color of the label.
    convenience init(text: String?, alignment: NSTextAlignment = .left, color: UIColor = .black) {
        self.init()
        self.ui
            .text(text)
            .text(color: color)
            .text(alignment: alignment)
    }
    
}
