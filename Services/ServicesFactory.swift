//
//  ServicesFactory.swift
//  Services
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Services locator
public final class ServicesFactory: DependencyFactory {
    
    /// Main network worker
    private var networkService: NetworkService {
        return shared(FLTNetworkService())
    }

    /// Service to deal with cars
    public var carsService: CarsService {
        return unshared(FLTCarsService()) { service in
            service.networkService = self.networkService
        }
    }
}
