//
//  ReactiveModal.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/04.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift

protocol ReactiveModal where Self: UIViewController {
    associatedtype Trait
    associatedtype Result

    var result: PrimitiveSequence<Trait, Result> { get }
}

extension ReactiveModal where Trait == CompletableTrait, Result == Never {
    func presentModal(baseVC: UIViewController) -> Completable {
        return Completable.create(subscribe: { [unowned self] (observer) -> Disposable in
            baseVC.present(UINavigationController.init(rootViewController: self), animated: true, completion: nil)

            return self.result
                .do(onDispose: { [unowned self] in
                    self.dismiss(animated: true, completion: nil)
                })
                .subscribe(observer)
        })
    }
}

extension ReactiveModal where Trait == SingleTrait {
    func presentModal(baseVC: UIViewController) -> Single<Result> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            baseVC.present(UINavigationController.init(rootViewController: self), animated: true, completion: nil)

            return self.result
                .do(onDispose: { [unowned self] in
                    self.dismiss(animated: true, completion: nil)
                })
                .subscribe(observer)
        })
    }
}

extension ReactiveModal where Trait == MaybeTrait {
    func presentModal(baseVC: UIViewController) -> Maybe<Result> {
        return Maybe.create(subscribe: { [unowned self] (observer) -> Disposable in
            baseVC.present(UINavigationController.init(rootViewController: self), animated: true, completion: nil)

            return self.result
                .do(onDispose: { [unowned self] in
                    self.dismiss(animated: true, completion: nil)
                })
                .subscribe(observer)
        })
    }
}
