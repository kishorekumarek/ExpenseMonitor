//
//  KSWorkItem.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation

struct KSWorkItem {
    let id: String
    var name: String
    var assignedTo: KSPerson
    var dueDate: String
    var comments: String?
    var eventId: String
}
