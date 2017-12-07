//
//  UIComponents.swift
//  UIComponents
//
//  Created by Azat Almeev on 07.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

extension Bundle {
    
    static let uiComponents = Bundle(identifier: "ru.azatalmeev.UIComponents")
}

extension String {
    
    var bundleImage: UIImage {
        return UIImage(named: self, in: .uiComponents, compatibleWith: nil)!
    }
}

/// Base view controller class with convenient init() method
open class BundleViewController: UIViewController {
    
    /// Initialize view controller with associated xib file
    public init() {
        let myType = type(of: self)
        super.init(nibName: "\(myType)", bundle: Bundle(for: myType))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Use simple init() instead")
    }
}
