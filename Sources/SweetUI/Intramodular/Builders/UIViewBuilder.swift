//
//  UIViewBuilder.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

@_functionBuilder
public struct UIViewBuilder {
    public typealias Content = () -> UIViewProvider
    
    public static func buildBlock(_ content: UIViewProvider...) -> UIViewProvider {
        guard content.count != 1 else { return content[0].view }
        let view = UIView()
        content.forEach { provider in
            view.ui.add(provider)
        }
        return view
    }
    
    public static func buildIf(_ content: UIViewProvider?) -> UIViewProvider { content ?? UIView() }

    public static func buildEither(first: UIViewProvider) -> UIViewProvider { first }

    public static func buildEither(second: UIViewProvider) -> UIViewProvider { second }
    
}
