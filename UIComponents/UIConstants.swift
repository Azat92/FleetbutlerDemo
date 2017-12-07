//
//  Constants.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

struct AlertStrings {
    
    private init() { }
    
    struct DateChoose {
        
        private init() { }
        
        static let title = "Filter"
        static let titleMessage = "Please select start and end date"
        static let startDate = "Start date"
        static let endDate = "End date"
        static let today = "Today"
        
        static let recents = "Recents"
        static let from = "From"
        static let to = "To"
    }
    
    static let ok = "OK"
    static let clear = "Clear"
    static let cancel = "Cancel"
}

public struct CommonStrings {
    
    private init() { }
    
    public static let tapToRetry = "Tap to retry"
}
