//
//  ViewProxy+UILabel.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

#if os(iOS)

// MARK: - Text
public extension ViewProxy where Base: UILabel {
    
    /// Sets a new value to managed label's attributed text property.
    ///
    /// - Parameter text: New text of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func attributedText(_ text: NSAttributedString?) -> Self {
        modified{ $0.attributedText = text }
    }
    
    /// Sets a new value to the managed label's text property, sets new text allignment and color.
    ///
    /// - Parameter text: New text for the label.
    /// - Parameter alignment: New text allignment for the label.
    /// - Parameter color: New text color of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(_ text: String?, alignment: NSTextAlignment, color: UIColor) -> Self {
        self.text(text)
            .text(alignment: alignment)
            .text(color: color)
    }
    
    /// Sets a new value to the managed label's text property and sets text allignment.
    ///
    /// - Parameter text: New text for the label.
    /// - Parameter alignment: New text allignment of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(_ text: String?, alignment: NSTextAlignment) -> Self {
        self.text(text)
            .text(alignment: alignment)
    }
    
    /// Sets a new value to the managed label's text property and sets text allignment.
    ///
    /// - Parameter text: New text for the label.
    /// - Parameter color: New text color of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(_ text: String?, color: UIColor) -> Self {
        self.text(text)
            .text(color: color)
    }
    
    /// Sets a new value to the managed label's text.
    ///
    /// - Parameter text: New text for of label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(_ text: String?) -> Self {
        modified { $0.text = text }
    }
    
    /// Sets a new value to the managed label's text color.
    ///
    /// - Parameter color: New text color of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(color: UIColor) -> Self {
        modified { $0.textColor = color }
    }
    
    /// Sets a new value to the managed label's highlighted text color.
    ///
    /// - Parameter color: New highlighted text color of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func highlightedText(color: UIColor) -> Self {
        modified { $0.highlightedTextColor = color }
    }
    
    /// Sets a new value to the managed label's text allignment property.
    ///
    /// - Parameter alignment: New text allignment of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func text(alignment: NSTextAlignment) -> Self {
        modified { $0.textAlignment = alignment }
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// Uses system font.
    ///
    /// - Parameter size: Label's new font size.
    /// - Parameter weight: Label's font new weight.
    /// - Returns: Caller instance.
    @discardableResult
    func font(size: CGFloat) -> Self {
        self.font(base.font.withSize(size))
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// - Parameter name: A name of label's new font.
    /// - Parameter size: Label's font new size.
    /// - Returns: Caller instance.
    @discardableResult
    func font(name: String, size: CGFloat) -> Self {
        modified { if let font = UIFont(name: name, size: size) { $0.ui.font(font) }}
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// - Parameter descriptor: A descriptor of label's new font.
    /// - Parameter size: Label's font new size.
    /// - Returns: Caller instance.
    @discardableResult
    func font(descriptor: UIFontDescriptor, size: CGFloat) -> Self {
        modified { $0.ui.font(.init(descriptor: descriptor, size: size)) }
    }
    
    /// Sets a new value to the managed label's font property.
    ///
    /// - Parameter font: New font of the label.
    /// - Returns: Caller instance.
    @discardableResult
    func font(_ font: UIFont) -> Self {
        modified { $0.font = font }
    }
    
}

#endif
