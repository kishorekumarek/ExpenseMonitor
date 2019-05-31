//
//  KSEvent.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation

struct KSEvent {
    let id: String
    let name: String
    let date: String
    let createdBy: KSPerson
    var mainPeople: [KSPerson]?
    var stakeHolders: [KSPerson]?
}
