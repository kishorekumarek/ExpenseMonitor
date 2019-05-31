//
//  FCErrorTracker.swift
//  FreshCaller
//
//  Created by Kishore Kumar Elanchezhiyan on 28/12/18.
//  Copyright © 2018 Freshworks. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum FCSharedSequenceError: Error {
    case emptyError
}

class FCErrorTracker: SharedSequenceConvertibleType {
    
    
    typealias SharingStrategy = DriverSharingStrategy
    
    let _subject = PublishSubject<Error>()
    
    fileprivate func trackError<O: ObservableConvertibleType>(source: O) -> Observable<O.E> {
        return source.asObservable().do(onError: onError)
    }
    
    func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _subject.asObservable().do(onError: { (_) in
            self._subject.onCompleted()
        }).asDriver(onErrorJustReturn: FCSharedSequenceError.emptyError)
    }
    
    func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }
    
    func onError(error: Error) {
        return _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    func trackError(error: FCErrorTracker) -> Observable<E> {
        return error.trackError(source: self)
    }
}
