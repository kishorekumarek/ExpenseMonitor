//
//  KSError.swift
//  KSExpenseMonitor
//
//  Created by Kishore Kumar Elanchezhiyan on 31/05/19.
//  Copyright © 2019 KiSh. All rights reserved.
//

import Foundation

enum KSError {
    case unknownError
    case invalidEmail
    case invalidPhone
    case personNotFound
    
   
}

extension KSError {
    var description: String {
        switch self {
        case .unknownError:
            return "Unknown Error"
        case .invalidEmail:
            return "Invalid Email"
        case .invalidPhone:
            return "Invalid Phone"
        case .personNotFound:
            return "Person Not Found"
        default:
            return "Unknown Error"
        }
    }
}

extension KSError {
    var code: Int {
        switch self {
        case .unknownError:
            return 100120
        case .invalidEmail:
            return 100
        case .invalidPhone:
            return 101
        case .personNotFound:
            return 102
        default:
            return 100120
        }
    }
}
