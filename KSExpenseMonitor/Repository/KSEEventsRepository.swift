//
//  KSEEventsRepository.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol KSEEventsRepository {
    func fetchEvents(email: String) -> Observable<KSResult<[KSEvent]>>
    func update(_ event: KSEvent) -> Observable<KSResult<Void>>
}
