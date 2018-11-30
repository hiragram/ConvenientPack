//
//  ReactiveModal.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/04.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift

public protocol ReactiveModal where Self: UIViewController {
    associatedtype Trait
    associatedtype Result

    var result: PrimitiveSequence<Trait, Result> { get }
    var wrapsWithNavigationController: Bool { get }
}

public extension ReactiveModal {
    var wrapsWithNavigationController: Bool {
        return true
    }
}

public extension ReactiveModal where Trait == CompletableTrait, Result == Never {
    public func presentModal(baseVC: UIViewController) -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            let vc: UIViewController
            if self.wrapsWithNavigationController {
                vc = UINavigationController.init(rootViewController: self)
            } else {
                vc = self
            }

            baseVC.present(vc, animated: true, completion: nil)

            return self.result
                .do(onDispose: { [unowned self] in
                    self.dismiss(animated: true, completion: nil)
                })
                .subscribe(observer)
        })
    }
}

public extension ReactiveModal where Trait == SingleTrait {
    public func presentModal(baseVC: UIViewController) -> Single<Result> {
        return Single.create(subscribe: { (observer) -> Disposable in
            let vc: UIViewController
            if self.wrapsWithNavigationController {
                vc = UINavigationController.init(rootViewController: self)
            } else {
                vc = self
            }

            baseVC.present(vc, animated: true, completion: nil)

            return self.result
                .do(onDispose: { [unowned self] in
                    self.dismiss(animated: true, completion: nil)
                })
                .subscribe(observer)
        })
    }
}

public extension ReactiveModal where Trait == MaybeTrait {
    public func presentModal(baseVC: UIViewController) -> Maybe<Result> {
        return Maybe.create(subscribe: { (observer) -> Disposable in
            let vc: UIViewController
            if self.wrapsWithNavigationController {
                vc = UINavigationController.init(rootViewController: self)
            } else {
                vc = self
            }

            baseVC.present(vc, animated: true, completion: nil)

            return self.result
                .do(onDispose: { [unowned self] in
                    self.dismiss(animated: true, completion: nil)
                })
                .subscribe(observer)
        })
    }
}
