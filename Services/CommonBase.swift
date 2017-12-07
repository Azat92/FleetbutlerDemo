//
//  CommonBase.swift
//  Services
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Type for use if we want to return some cancellation token
public typealias Cancellable = () -> Void

/// General result representing for actions
///
/// - success: if action succeeded
/// - failure: if some error occured
public enum FLTResult<T> {
    
    case success(T)
    case failure(Error)
}
