//
//  Modification.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

func modification<Object>(of object: Object, with transform: (inout Object) -> Void) -> Object {
    var _object = object
    transform(&_object)
    return _object
}
