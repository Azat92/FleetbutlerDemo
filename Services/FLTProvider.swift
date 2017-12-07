//
//  FLTProvider.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 22.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Represents provider entity from the backend
public struct FLTProvider: Codable {
    
    public let id: Int
    public let name: String
    public let image: FLTImage
}
