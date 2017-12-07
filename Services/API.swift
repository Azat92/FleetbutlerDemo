//
//  API.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 28.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Supported HTTP methods
///
/// - get: GET method
enum HTTPMethod {
    
    case get
}

/// Basic class for API manaement
final class API {
    
    private static let baseURLPath = "https://development.fleetbutler.de/api"
    
    /// Default JSON parser
    ///
    /// - Parameter input: data to parse from
    /// - Returns: parsed model
    static func jsonParser<T: Decodable>(_ input: Data?) -> T? {
        guard let data = input else { return nil }
        let jsonDecoder = JSONDecoder()
        return try? jsonDecoder.decode(T.self, from: data)
    }
    
    /// Default errors parser
    ///
    /// - Parameter input: data to parse from
    /// - Returns: parsed errors
    static func errorsParser(_ input: Data?) -> [FLTError]? {
        let errorList: FLTErrorList?? = jsonParser(input)
        return errorList??.errors
    }
}

extension API {
    
    /// Contains endpoints related to cars service
    struct Cars {
        
        /// Issues a rental request
        ///
        /// - Parameters:
        ///   - pageNum: page to load
        ///   - startDate: from date to filter
        ///   - endDate: until date to filter
        /// - Returns: ready resource to be loaded in network service
        static func rent(pageNum: Int, startDate: Date?, endDate: Date?) -> Resource<FLTCarList> {
            return Resource(path: API.baseURLPath + "/cars", method: .get, parameters: ["page" : pageNum, "from" : startDate, "until" : endDate], parser: API.jsonParser)
        }
    }
}
