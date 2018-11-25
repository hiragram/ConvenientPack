//
//  StoryboardInstantiatable.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/25.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit

public protocol StoryboardInstantiatable {
    static var storyboardName: String { get }
}

public extension StoryboardInstantiatable where Self: UIViewController {
    static var storyboardName: String {
        return String.init(describing: Self.self)
    }

    static func instantiateFromStoryboard() -> Self {
        return UIStoryboard.init(name: Self.storyboardName, bundle: Bundle.init(for: Self.self)).instantiateInitialViewController() as! Self
    }
}
