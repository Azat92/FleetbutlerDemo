//
//  FLTError.swift
//  Services
//
//  Created by Azat Almeev on 07.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

struct FLTErrorList: Codable {
    
    let errors: [FLTError]
}

/// Represents error from backend
struct FLTError: Codable {

    let name: String
    let messages: [String]
    let reasons: [String]
}

extension FLTError {
    
    var asError: Error {
        let errorMessage = messages.joined(separator: "; ")
        return NSError(domain: "ru.azatalmeev.FleetbutlerDemo", code: 1, userInfo: [NSLocalizedDescriptionKey : errorMessage])
    }
}
