//
//  SerialCounter.swift
//  ConvenientPack
//
//  Created by Yuya Hirayama on 2018/12/08.
//  Copyright © 2018年 Yuya Hirayama. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public final class SerialCounter {
    // Never make this public.
    private let tasks: BehaviorRelay<[String: Int]>

    private let queue = DispatchQueue.global(qos: .default)

    public init() {
        tasks = BehaviorRelay.init(value: [:])
    }

    public func retain(taskIdentifier: String) {
        queue.sync {
            let nextCount: Int
            if let currentCount = tasks.value[taskIdentifier] {
                nextCount = currentCount + 1
            } else {
                nextCount = 1
            }
            var nextDict = tasks.value
            nextDict[taskIdentifier] = nextCount
            tasks.accept(nextDict)
        }
    }

    public func release(taskIdentifier: String) {
        queue.sync {
            guard let currentCount = tasks.value[taskIdentifier] else {
                preconditionFailure("This task is not registered. It may be an over-release.")
            }

            var nextDict = tasks.value
            if currentCount == 1 {
                nextDict[taskIdentifier] = nil
            } else {
                nextDict[taskIdentifier] = currentCount - 1
            }
            tasks.accept(nextDict)
        }
    }

    public var isActive: Observable<Bool> {
        return tasks
            .map {
                $0.values.reduce(0, { (total, element) -> Int in
                    return total + element
                })
            }
            .map { $0 > 0}
    }
}
