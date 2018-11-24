//
//  ViewModelInjectable.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/03.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit

public protocol ViewModelInjectable where Self: UIViewController {
    associatedtype ViewModel: RepositoryInjectableViewModel

    var viewModel: ViewModel { get set }
}
