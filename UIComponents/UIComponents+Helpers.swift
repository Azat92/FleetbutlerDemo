//
//  Helpers.swift
//  UIComponents
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

extension UITextField {
    
    var isEmpty: Bool {
        return (text ?? "").isEmpty
    }
}

extension UIView {
    
    var width: CGFloat {
        get {
            return frame.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return frame.height
        }
        set {
            frame.size.height = newValue
        }
    }
}
