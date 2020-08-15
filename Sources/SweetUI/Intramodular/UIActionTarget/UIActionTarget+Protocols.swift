//
//  UIActionTarget+Protocols.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

protocol DefaultTargetInitializable: AnyObject {
    init(target: Any?, action: Selector?)
}

extension DefaultTargetInitializable {
    public init(handler: @escaping (Self) -> Void) {
        let target = UIActionTarget()
        self.init(target)
        target.setAction { handler(self) }
    }
    
    public init(_ target: UIActionTarget) {
        self.init(target: target, action: target.selector)
    }
}

protocol DefaultTargetContainer: AnyObject {
    func addTarget(_ target: Any, action: Selector)
    func removeTarget(_ target: Any?, action: Selector?)
}

extension DefaultTargetContainer {
    public func addTarget(_ target: UIActionTarget) {
        addTarget(target, action: target.selector)
    }
    
    public func removeTarget(_ target: UIActionTarget) {
        removeTarget(target, action: target.selector)
    }
}
