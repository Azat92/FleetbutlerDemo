//
//  CarListPresenter.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit
import Services

extension FLTCarList: FLTPaginationModel {
    
    public var objects: [FLTCar] {
        return cars
    }
}

final class CarListPresenter: FLTPaginationPresenter<FLTCar, FLTCarList> {

    /// Cars service dependency
    var carsService: CarsService!
    
    /// Reference to view
    weak var view: CarListViewInput?
    
    /// Currently set start date
    private var startDate: Date?
    
    /// Currently set end date
    private var endDate: Date?
    
    override func on(reload objects: [FLTCar]) {
        performInMain {
            self.view?.on(reload: objects)
        }
    }
    
    override func on(append objects: [FLTCar]) {
        performInMain {
            self.view?.on(append: objects)
        }
    }
    
    override func on(error: Error) {
        performInMain {
            self.view?.on(error: error)
        }
    }
    
    override func load(page: Int, completion: @escaping (FLTResult<FLTCarList>) -> Void) -> Cancellable {
        return carsService.rent(pageNum: page, startDate: startDate, endDate: endDate, completion: completion)
    }
}

extension CarListPresenter: CarListViewOutput {
    
    var cars: [FLTCar] {
        return objects
    }
    
    func set(startDate: Date?, endDate: Date?) {
        self.startDate = startDate
        self.endDate = endDate
    }
}
