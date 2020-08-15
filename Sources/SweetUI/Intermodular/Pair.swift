//
//  Pair.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

struct Pair<First, Second> {
    var first: First
    var second: Second
    
    init(_ pair: (First, Second)) {
        self.init(pair.0, pair.1)
    }
    
    init(_ first: First, _ second: Second) {
        self.init(first: first, second: second)
    }
    
    init(first: First, second: Second) {
        self.first = first
        self.second = second
    }
    
    func inverted() -> Pair<Second, First> {
        return .init(first: second, second: first)
    }
}
