//
//  KSPersonRepository.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol KSPersonRepository {
    func getPersons() -> Observable<KSResult<[KSPerson]>>
    func update(_ person: KSPerson) -> Observable<KSResult<Void>>
    func getPerson(emailOrPhone: String) -> Observable<KSResult<KSPerson>>
}
