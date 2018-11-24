//
//  RootViewController.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/03.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit

public final class RootViewController: UIViewController {
    private var rootViewController: UIViewController?

    override public func viewDidLoad() {
        super.viewDidLoad()

        if let rootVC = rootViewController {
            set(rootViewController: rootVC)
        }
    }

    public func set(rootViewController rootVC: UIViewController) {
        rootViewController?.removeFromParent()
        rootViewController?.view.removeFromSuperview()
        rootViewController = rootVC

        addChild(rootVC)

        if isViewLoaded {
            addToViewHierarchy(rootVC)
        }
    }

    private func addToViewHierarchy(_ vc: UIViewController) {
        view.addSubview(vc.view)
        let constraints = [NSLayoutConstraint.Attribute.top, .bottom, .left, .right].map {
            NSLayoutConstraint.init(item: view, attribute: $0, relatedBy: .equal, toItem: vc.view, attribute: $0, multiplier: 1, constant: 0)
        }
        view.addConstraints(constraints)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.didMove(toParent: self)
        updateViewConstraints()
    }
}
