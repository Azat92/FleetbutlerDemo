//
//  CarListConfigurator.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit
import Services

/// Configurator for Car List Module
final class CarListConfigurator {
    
    /// Creates correct module with all dependencies setup
    ///
    /// - Returns: view controller to present 
    static func configureModule() -> UIViewController {
        let view = CarListViewController()
        let presenter = CarListPresenter()
        presenter.carsService = Services.servicesFactory.carsService
        view.output = presenter
        presenter.view = view
        return view
    }
}
