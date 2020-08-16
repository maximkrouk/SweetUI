//
//  FutureLayoutConfigurator.swift
//  SweetUI
//
//  Created by Maxim Krouk on 15/08/20.
//  Copyright © 2020 @maximkrouk. All rights reserved.
//

protocol FutureLayoutConfigurator {
    func configureLayout()
}

struct FutureLayoutContainer: UIViewProvider & FutureLayoutConfigurator {
    var view: UIView
    var childConfigurators: [FutureLayoutConfigurator]
    
    init(view: UIView, childConfigurators: [FutureLayoutConfigurator] = []) {
        self.view = view
        self.childConfigurators = childConfigurators
    }
    
    func configureLayout() {
        childConfigurators.forEach { $0.configureLayout() }
    }
}
