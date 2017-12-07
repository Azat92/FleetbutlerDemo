//
//  Resource.swift
//  Services
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Base protocol for easy converting different types in HTTP requests
protocol APIParameter {
    
    /// String representation of parameter
    var stringValue: String { get }
}

/// Struct for indicating any resource that we fetch from a server
struct Resource<T> {
    
    /// Loading query path
    let path: String
    
    /// Method to use
    let method: HTTPMethod
    
    /// Parameters to send
    let parameters: [String : APIParameter?]
    
    /// Parser to use to create objects from raw data
    let parser: (Data?) -> T?
    
    /// Instantiates resource with given parameters
    ///
    /// - Parameters:
    ///   - path: loading query path
    ///   - method: method to use
    ///   - parameters: parameters to send
    ///   - parser: parser to use to create objects from raw data
    init(path: String, method: HTTPMethod, parameters: [String : APIParameter?], parser: @escaping (Data?) -> T?) {
        self.path = path
        self.method = method
        self.parameters = parameters
        self.parser = parser
    }
}

extension Int: APIParameter {
    
    var stringValue: String {
        return "\(self)"
    }
}

extension Date: APIParameter {
    
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()
    
    var stringValue: String {
        return Date.formatter.string(from: self)
    }
}
