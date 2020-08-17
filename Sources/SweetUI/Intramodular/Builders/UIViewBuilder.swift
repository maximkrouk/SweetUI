//
//  UIViewBuilder.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

@_functionBuilder
public enum UIViewBuilder {
    public typealias Content = () -> UIViewProvider
    
    public static func buildBlock(_ content: UIViewProvider...) -> UIViewProvider {
        let containerView = UIView()
        content.forEach { provider in
            containerView.ui.add(provider)
        }
        return FutureLayoutContainer(
            view: containerView,
            childConfigurators: [
                containerView
                    .layout.edges.equalToSuperview()
            ]
        )
    }
    
    public static func buildIf(_ content: UIViewProvider?) -> UIViewProvider { content ?? UIView(frame: .zero) }

    public static func buildEither(first: UIViewProvider) -> UIViewProvider { first }

    public static func buildEither(second: UIViewProvider) -> UIViewProvider { second }
    
}
