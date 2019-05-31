//
//  KSExpenseRepository.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol KSExpenseRepository {
    func getExpenses(workItem: KSWorkItem) -> Observable<KSResult<[KSExpense]>>
    func update(_ expense: KSExpense) -> Observable<KSResult<Void>>
}

