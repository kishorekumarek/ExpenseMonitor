//
//  FCActivityIndicator.swift
//  FreshCaller
//
//  Created by Kishore Kumar Elanchezhiyan on 28/12/18.
//  Copyright © 2018 Freshworks. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FCActivityIndicator: SharedSequenceConvertibleType {

    typealias SharingStrategy = DriverSharingStrategy
    typealias E = Bool

    private let _lock = NSRecursiveLock()
    private let _variable = Variable(false)
    private let _loading: SharedSequence<SharingStrategy, Bool>
    
    public init() {
        _loading = _variable.asDriver().distinctUntilChanged()
    }
    
    fileprivate func trackActivityOfObservable<O: ObservableConvertibleType>(_ source: O) -> Observable<O.E> {
        return source.asObservable()
            .do(onNext: { _ in
                self.sendStopLoading()
            }, onError: { _ in
                self.sendStopLoading()
            }, onCompleted: {
                self.sendStopLoading()
            }, onSubscribe: subscribed)
    }
    
    private func subscribed() {
        _lock.lock()
        _variable.value = true
        _lock.unlock()
    }
    
    private func sendStopLoading() {
        _lock.lock()
        _variable.value = false
        _lock.unlock()
    }
    
    func asSharedSequence() -> SharedSequence<DriverSharingStrategy, Bool> {
        return _loading
    }
}

extension ObservableConvertibleType {
    func trackActivity(_ activityIndicator: FCActivityIndicator) -> Observable<E> {
        return activityIndicator.trackActivityOfObservable(self)
    }
}
