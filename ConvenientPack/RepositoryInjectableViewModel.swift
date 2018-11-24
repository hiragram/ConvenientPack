//
//  RepositoryInjectableViewModel.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/03.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import Foundation

public protocol RepositoryInjectableViewModel {
    associatedtype Repository

    init(repository: Repository)
}
