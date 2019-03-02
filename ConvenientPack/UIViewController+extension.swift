//
//  UIViewController+extension.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/03.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit

public extension ViewModelInjectable where Self: UIViewController & XibInstantiatable {
    init(repository: (() -> ViewModel.Repository)) {
        self.init(nibName: Self.xibName, bundle: Bundle.init(for: Self.self))
        viewModel = ViewModel.init(repository: repository())
    }
}

public extension ViewModelInjectable where Self: UIViewController & StoryboardInstantiatable {
    static func instantiate(repository: () -> ViewModel.Repository) -> Self {
        let _self = Self.instantiateFromStoryboard()
        _self.viewModel = ViewModel.init(repository: repository())

        return _self
    }
}

public extension UIViewController {
    func embedInNavigationController() -> UINavigationController {
        return UINavigationController.init(rootViewController: self)
    }
}
