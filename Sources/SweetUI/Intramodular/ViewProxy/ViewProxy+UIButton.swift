//
//  ViewProxy+UIButton.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

public extension ViewProxy where Base: UIButton {
    
    /// Associates a target object and action method with the control.
    ///
    /// See UIControl.addTarget(...) documentation for more info.
    @discardableResult
    func onTap(_ target: UIActionTarget) -> Self {
        modified {
            $0.addTarget(target, action: target.selector, for: .touchUpInside)
            target.retain()
        }
    }
    
}

// MARK: - Text
public extension ViewProxy where Base: UIButton {
    
    /// Sets a new value to managed label's attributed text property.
    ///
    /// - Parameter text: New text of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func attributedText(_ text: NSAttributedString?) -> Self {
        modified{ $0.titleLabel?.ui.attributedText(text) }
    }
    
    /// Sets a new value to the managed label's text property, sets new text allignment and color.
    ///
    /// - Parameter text: New text for the label.
    /// - Parameter alignment: New text allignment for the label.
    /// - Parameter color: New text color of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(_ text: String?, alignment: NSTextAlignment, color: UIColor) -> Self {
        self.title(text)
            .title(alignment: alignment)
            .title(color: color)
    }
    
    /// Sets a new value to the managed label's text property and sets text allignment.
    ///
    /// - Parameter text: New text for the label.
    /// - Parameter alignment: New text allignment of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(_ text: String?, alignment: NSTextAlignment) -> Self {
        self.title(text)
            .title(alignment: alignment)
    }
    
    /// Sets a new value to the managed label's text property and sets text allignment.
    ///
    /// - Parameter text: New text for the label.
    /// - Parameter color: New text color of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func title(_ text: String?, color: UIColor?, for state: UIControl.State = .normal) -> Self {
        self.title(text, for: state)
            .title(color: color, for: state)
    }
    
    /// Sets a new value to the managed label's text.
    ///
    /// - Parameter text: New text for of label.
    /// - Returns: Caller instance.
    @discardableResult
    func title(_ text: String?, for state: UIControl.State = .normal) -> Self {
        modified { $0.setTitle(text, for: state) }
    }
    
    /// Sets a new value to the managed label's text color.
    ///
    /// - Parameter color: New text color of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func title(color: UIColor?, for state: UIControl.State = .normal) -> Self {
        modified { $0.setTitleColor(color, for: state) }
    }
    
    /// Sets a new value to the managed label's text allignment property.
    ///
    /// - Parameter alignment: New text allignment of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func title(alignment: NSTextAlignment) -> Self {
        modified { $0.titleLabel?.ui.text(alignment: alignment) }
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// Uses system font.
    ///
    /// - Parameter size: Label's new font size.
    /// - Parameter weight: Label's font new weight.
    /// - Returns: Caller instance.
    @discardableResult
    func font(size: CGFloat, _ weight: UIFont.Weight = .regular) -> Self {
        self.font(.system(ofSize: size, weight: weight))
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// - Parameter name: A name of label's new font.
    /// - Parameter size: Label's font new size.
    /// - Returns: Caller instance.
    @discardableResult
    func font(name: String, size: CGFloat) -> Self {
        modified { $0.titleLabel?.ui.font(name: name, size: size) }
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// - Parameter descriptor: A descriptor of label's new font.
    /// - Parameter size: Label's font new size.
    /// - Returns: Caller instance.
    @discardableResult
    func font(descriptor: UIFontDescriptor, size: CGFloat) -> Self {
        modified { $0.titleLabel?.ui.font(descriptor: descriptor, size: size) }
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// - Parameter font: New font of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func font(_ font: UIFont) -> Self {
        modified { $0.titleLabel?.ui.font(font) }
    }
    
}
