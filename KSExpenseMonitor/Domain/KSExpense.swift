//
//  KSExpense.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation

struct KSExpense {
    let id: String
    var name: String
    var description: String?
    var estimatedAmount: String
    var spentAmount: String?
    var comments: String?
    var paidBy: KSPerson
    var workItemId: String
}
