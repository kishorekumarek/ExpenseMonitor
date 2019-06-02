//
//  KSLoginViewModel.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

//enum LoginResult {
//     case success, invalidEmail, invalidPhone, loading
//}

class KSELoginViewModel: KSEViewModelType {
    
    private let repository: KSPersonRepository
    private let navigator: KSNavigator
    
    init(repository: KSPersonRepository, navigator:  KSNavigator) {
        self.repository = repository
        self.navigator = navigator
    }
    
    struct Input {
        let submitTrigger: Driver<String>
    }
    
    struct Output {
        let result: Driver<KSResult<KSPerson>>
    }
    
    func transform(input: KSELoginViewModel.Input) -> KSELoginViewModel.Output {
        let result = input.submitTrigger.flatMapLatest { str -> Driver<(String, KSResult<KSPerson>)> in
            if str.isValidEmail() {
                return self.repository.getPerson(emailOrPhone: str).asDriver(onErrorJustReturn: KSResult.error(KSError.unknownError.description)).map{ (str, $0)}
            } else {
                return Observable.just(KSResult<KSPerson>.error("Invalid Data")).asDriver(onErrorJustReturn: KSResult.error(KSError.unknownError.description)).map{ (str, $0)}
            }
            }.do(onNext: { (result) in
                switch result.1 {
                case .success:
                    self.navigator.toSignUp(email: result.0)
                    break
                case .error(let error):
                    if error == KSError.personNotFound.description {
                        self.navigator.toEvents(email: result.0)
                    }
                    break
                default:
                    print("")
                }
            }).map { $0.1 }
        
        return Output(result: result)
    }
}
