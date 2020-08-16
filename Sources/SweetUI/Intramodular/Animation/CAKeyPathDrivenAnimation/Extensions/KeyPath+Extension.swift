//
//  KeyPath+Extension.swift
//  PropertyWrapprs-tries
//
//  Created by Maxim Krouk on 3/14/20.
//  Copyright © 2020 Maxim Krouk. All rights reserved.
//

// Objc-like string keypath from a Swifty one
extension AnyKeyPath {
    /// Returns key path represented as a string
    public var asString: String? {
        return _kvcKeyPathString?.description
    }
}
