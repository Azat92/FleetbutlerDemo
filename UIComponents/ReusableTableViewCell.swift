//
//  ReusableTableViewCell.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Basic cell for reusable table cels
open class ReusableTableViewCell: UITableViewCell {
    
    private class var bundle: Bundle {
        return Bundle(for: self)
    }
    
    private static var id: String {
        let target = bundle.infoDictionary?["CFBundleName"] as! String
        return NSStringFromClass(self).replacingOccurrences(of: "\(target).", with: "")
    }
    
    fileprivate static var nib: UINib {
        return UINib(nibName: id, bundle: bundle)
    }
    
    fileprivate static var cellIdentifier: String {
        return "\(id)Identifier"
    }
}

public extension UITableView {
    
    /// Registers reusable cell for table with given type
    ///
    /// - Parameter type: type to register
    func register<T: ReusableTableViewCell>(with type: T.Type) {
        register(T.nib, forCellReuseIdentifier: T.cellIdentifier)
    }
    
    /// Dequeues from table cell with given type
    ///
    /// - Parameter type: type of cell to dequeue
    /// - Returns: type safe cell
    func dequeue<T: ReusableTableViewCell>(with type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: type.cellIdentifier) as! T
    }
}
