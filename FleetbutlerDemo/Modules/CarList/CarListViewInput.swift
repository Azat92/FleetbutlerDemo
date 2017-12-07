//
//  CarListViewInput.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit
import Services

/// Protocol for view
protocol CarListViewInput: class {

    /// Called when new data list is available
    ///
    /// - Parameter objects: new fetched objects
    func on(reload objects: [FLTCar])
    
    /// Called when lazy loading mechanism fetches new data
    ///
    /// - Parameter objects: new fetched objects to append
    func on(append objects: [FLTCar])
    
    /// Called when error occured during loading
    ///
    /// - Parameter error: error to display on view
    func on(error: Error)
}
