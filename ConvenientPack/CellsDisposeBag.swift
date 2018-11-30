//
//  CellsDisposeBag.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/30.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift

public final class CellsDisposeBag {
    private var bags: [ObjectIdentifier: DisposeBag] = [:]

    func bag(for cell: UITableViewCell) -> DisposeBag {
        if let stored = bags[ObjectIdentifier.init(cell)] {
            return stored
        } else {
            let bag = DisposeBag.init()
            bags[ObjectIdentifier.init(cell)] = bag
            return bag
        }
    }

    public func disposeSubscriptions(for cell: UITableViewCell) {
        bags[ObjectIdentifier.init(cell)] = nil
    }

    public init() {}
}

public extension Disposable {
    public func disposed(by bag: CellsDisposeBag, cell: UITableViewCell) {
        disposed(by: bag.bag(for: cell))
    }
}
