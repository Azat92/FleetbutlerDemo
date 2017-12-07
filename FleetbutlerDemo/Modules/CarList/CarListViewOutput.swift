//
//  CarListViewOutput.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit
import Services

/// Protocol for presenter
protocol CarListViewOutput {
    
    /// Cars list currently fetched
    var cars: [FLTCar] { get }
    
    /// Indicating whether there are other objects to be fetched lazily
    var hasMore: Bool { get }

    /// Setups filter for request
    ///
    /// - Parameters:
    ///   - startDate: date to start with
    ///   - endDate: date to end with
    func set(startDate: Date?, endDate: Date?)
    
    /// Asks to reload list, reset page to 1
    func reload()
    
    /// Asks to load more data lazily
    func loadMore()
}
