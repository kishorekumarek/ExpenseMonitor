//
//  File.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol KSWorkItemRepository {
    func getWorkItems(event: KSEvent) -> Observable<KSResult<[KSWorkItem]>>
    func update(_ Item: KSWorkItem) -> Observable<KSResult<Void>>
}
