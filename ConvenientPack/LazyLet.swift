//
//  LazyLet.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/25.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import Foundation

struct LazyLet<T>{
    private(set) lazy var value = block()

    private let block: () -> T

    init(block: @escaping () -> T) {
        self.block = block
    }
}
