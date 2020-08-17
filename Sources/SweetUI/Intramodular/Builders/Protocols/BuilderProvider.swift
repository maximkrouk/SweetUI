//
//  BuilderProvider.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

public protocol BuilderProvider {}
extension BuilderProvider {
    public var builder: Builder<Self> { .init(self) }
}

extension NSObject: BuilderProvider {}
