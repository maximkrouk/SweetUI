//
//  KeyPath+Extension.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

extension AnyKeyPath {
    /// Returns key path represented as a string
    public var asString: String? {
        return _kvcKeyPathString?.description
    }
}
