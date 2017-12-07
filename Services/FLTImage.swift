//
//  FLTImage.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 22.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Represents image entity from the backend
public struct FLTImage: Codable {
    
    private let urlString: String
    private let previewString: String
    private let thumbString: String
    
    public var url: URL {
        return urlString.url
    }
    
    public var preview: URL {
        return previewString.url
    }
    
    public var thumb: URL {
        return thumbString.url
    }
    
    private enum CodingKeys: String, CodingKey {
        case urlString = "url"
        case previewString = "medium_url"
        case thumbString = "thumb_url"
    }
}
