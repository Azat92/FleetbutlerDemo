//
//  FLTNetManager.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Protocol for network service
protocol NetworkService {
    
    /// Load given resource and notify with completion handler
    ///
    /// - Parameters:
    ///   - resource: resource to load
    ///   - completion: callback to call when done
    /// - Returns: cancellation token
    func load<T>(resource: Resource<T>, completion: @escaping (FLTResult<T>) -> Void) -> Cancellable
}

private extension HTTPMethod {
    
    var stringValue: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}

private extension Resource {
    
    /// Put some default headers to use in request
    var headers: [String : String] {
        return ["X-Selected-Team" : "35692919",
                "Authorization" : "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjQ2ODQ5Njc0N30.MXiJcFETVH2vrjw3vBCkuJRRZ9X-wNw_XMO4uTmwh74"]
    }
    
    /// Convenient URL maker
    var url: URL {
        var components = URLComponents(string: path)!
        components.queryItems = parameters.flatMap { (key, param) in
            guard let value = param?.stringValue else { return nil }
            return URLQueryItem(name: key, value: value)
        }
        return components.url!
    }
}

/// Default network service implementation
final class FLTNetworkService: NetworkService {
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    private let generalError = NSError(domain: "ru.azatalmeev.FleetbutlerDemo", code: 1, userInfo: [NSLocalizedDescriptionKey : "General network error"])
    
    func load<T>(resource: Resource<T>, completion: @escaping (FLTResult<T>) -> Void) -> Cancellable {
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.stringValue
        for (key, value) in resource.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let task = session.dataTask(with: request) { (data, response, error) in
            if let result = resource.parser(data) {
                completion(.success(result))
            }
            else if let errors = API.errorsParser(data), let error = errors.first {
                completion(.failure(error.asError))
            }
            else {
                completion(.failure(error ?? self.generalError))
            }
        }
        task.resume()
        return { [weak task] in
            task?.cancel()
        }
    }
}
