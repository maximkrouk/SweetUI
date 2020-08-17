//
//  CATransaction+Extension.swift
//  SweetUI
//
//  Created by Maxim Krouk on 17/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
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
