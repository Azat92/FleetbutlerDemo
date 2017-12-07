//
//  FLTCar.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 22.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Represents cars list entity from the backend
public struct FLTCarList: Codable {
    
    public let cars: [FLTCar]
}

/// Represents car entity from the backend
public struct FLTCar: Codable {
    
    /// Represents car model entity from the backend
    public struct Model: Codable {
        
        /// Represents car model manufacturer from the backend
        public struct Manufacturer: Codable {
            
            public let name: String
        }
        
        public let name: String
        public let modelName: String
        public let manufacturer: Manufacturer
        
        private enum CodingKeys: String, CodingKey {
            case name
            case modelName = "model_name"
            case manufacturer = "car_manufacturer"
        }
    }
    
    /// Represents car fuel state from the backend
    public struct Fuel: Codable {
        
        public let cents: Int
        public let value: String
        public let formatted: String
    }

    public let id: Int
    public let license: String
    public let model: Model
    public let image: FLTImage
    public let fuel: Fuel
    public let provider: FLTProvider
    
    private enum CodingKeys: String, CodingKey {
        case id
        case license
        case model = "car_model"
        case image
        case fuel
        case provider
    }
}
