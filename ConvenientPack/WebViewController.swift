//
//  WebViewController.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/12/01.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit
import SafariServices
import RxSwift

@available(*, unavailable)
public final class WebViewController: UIViewController, ReactiveModal {
    private let _completed = PublishSubject<Never>.init()

    public var result: PrimitiveSequence<CompletableTrait, Never> {
        return _completed.asCompletable()
    }

    public init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public typealias Trait = CompletableTrait
    public typealias Result = Never

    private lazy var url: URL = uninitialized()

    public override func viewDidLoad() {
        super.viewDidLoad()

        let safari = SFSafariViewController.init(url: url)
        view.addSubview(safari.view)
        safari.view.translatesAutoresizingMaskIntoConstraints = false

        [
            safari.view.topAnchor.constraint(equalTo: view.topAnchor),
            safari.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            safari.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            safari.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            ].forEach { $0.isActive = true }

        addChild(safari)
        safari.didMove(toParent: self)
    }

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        _completed.onCompleted()

        super.dismiss(animated: flag, completion: completion)
    }
}
