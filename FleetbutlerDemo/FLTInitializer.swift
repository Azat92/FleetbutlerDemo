//
//  FLTInitializer.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Global initializer for app
final class FLTInitializer {

    /// Setup root view controller
    ///
    /// - Returns: key window to store in AppDelegate
    static func setupWindow() -> UIWindow {
        let vc = CarListConfigurator.configureModule()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
        return window
    }
}
