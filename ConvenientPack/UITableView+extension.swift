//
//  UITableView+extension.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/25.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit

public extension UITableView {
    public func registerXib(cellType: (UITableViewCell & XibInstantiatable).Type) {
        self.register(UINib.init(nibName: cellType.xibName, bundle: Bundle.init(for: cellType)), forCellReuseIdentifier: cellType.xibName)
    }

    public func dequeue<T: UITableViewCell & XibInstantiatable>(indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.xibName, for: indexPath) as! T
    }
}
