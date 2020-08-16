//
//  CATransaction+Extension.swift
//  PropertyWrapprs-tries
//
//  Created by Maxim Krouk on 3/14/20.
//  Copyright © 2020 Maxim Krouk. All rights reserved.
//

import UIKit

// Atomic change
extension CATransaction {
    
    public static func execute(code: () -> Void) {
        begin()
        setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        code()
        setValue(kCFBooleanFalse, forKey: kCATransactionDisableActions)
        commit()
    }
    
}
