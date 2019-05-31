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
        
        let result = input.submitTrigger.flatMapLatest { return self.repository.getPerson(emailOrPhone: $0).asDriver(onErrorJustReturn: KSResult.error("Unexpected Error")) }
        
        return Output(result: result)
    }
}
