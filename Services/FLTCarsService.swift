//
//  FLTCarListLoader.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Public API for cars service
public protocol CarsService {
    
    /// Issues a request to backend
    ///
    /// - Parameters:
    ///   - pageNum: page to load
    ///   - startDate: start date filter
    ///   - endDate: end date filter
    ///   - completion: callback to get results
    /// - Returns: cancellation token
    func rent(pageNum: Int, startDate: Date?, endDate: Date?, completion: @escaping (FLTResult<FLTCarList>) -> Void) -> Cancellable
}

/// Default cars service implementation
final class FLTCarsService: CarsService {
    
    var networkService: NetworkService!
    
    func rent(pageNum: Int, startDate: Date?, endDate: Date?, completion: @escaping (FLTResult<FLTCarList>) -> Void) -> Cancellable {
        let resource = API.Cars.rent(pageNum: pageNum, startDate: startDate, endDate: endDate)
        return networkService.load(resource: resource, completion: completion)
    }
}
