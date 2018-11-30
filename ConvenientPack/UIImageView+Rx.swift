//
//  UIImageView+Rx.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/11/30.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public extension Reactive where Base: UIImageView {
    public func fadeIn(_ stream: Observable<UIImage?>) -> Disposable {
        return stream.subscribe(onNext: { (image) in
            self.base.alpha = 0
            self.base.image = image
            UIView.animate(withDuration: 0.3, animations: {
                self.base.alpha = 1
            })
        })
    }

    public func fadeIn(_ stream: Observable<UIImage>) -> Disposable {
        return stream.map { Optional.some($0) }
            .bind(to: fadeIn)
    }
}
