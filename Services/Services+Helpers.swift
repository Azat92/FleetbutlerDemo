//
//  Helpers.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

func performInMain(_ closure: @escaping () -> Void) {
    DispatchQueue.main.async(execute: closure)
}

extension String {
    
    var url: URL {
        return asURL!
    }
    
    var asURL: URL? {
        return URL(string: self)
    }
}
