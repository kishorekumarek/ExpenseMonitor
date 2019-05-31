//
//  KSEViewModelType.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation

protocol KSEViewModelType {
    
    associatedtype Input
    associatedtype Output
   
    func transform(input: Input) -> Output
}
