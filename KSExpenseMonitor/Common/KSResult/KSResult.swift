//
//  KSDataResult.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation

enum KSResult<KSData> {
    case success(KSData?)
    case error(String)
    case loading
}
