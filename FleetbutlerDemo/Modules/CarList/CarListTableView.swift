//
//  CarListTableView.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 06.12.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit
import UIComponents

/// Custom table view ready for car list module
final class CarListTableView: UITableView {

    override func awakeFromNib() {
        super.awakeFromNib()
        rowHeight = 70
        register(with: CarTableViewCell.self)
        register(with: LoadingTableViewCell.self)
    }
}
