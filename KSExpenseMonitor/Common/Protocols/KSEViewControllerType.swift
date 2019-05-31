//
//  KSEViewControllerType.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation

protocol KSEViewControllerType {
   
    associatedtype ViewModel: KSEViewModelType
   
    var viewModel: ViewModel! { get set }
    func bindViewModel()
    
}
