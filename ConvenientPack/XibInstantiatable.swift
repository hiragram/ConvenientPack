//
//  XibInstantiatable.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/03.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit

public protocol XibInstantiatable {
    static var xibName: String { get }
}

public extension XibInstantiatable {
    static var xibName: String {
        return String.init(describing: Self.self)
    }
}

public extension XibInstantiatable where Self: UIView {
    init() {
        self = UINib.init(nibName: Self.xibName, bundle: Bundle.init(for: Self.self)).instantiate(withOwner: nil, options: nil).first as! Self
    }
}

public extension XibInstantiatable where Self: UIViewController {
    init() {
        self.init(nibName: Self.xibName, bundle: Bundle.init(for: Self.self))
    }
}
