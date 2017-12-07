//
//  CarTableViewCell.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit
import Services
import SDWebImage
import UIComponents

final class CarTableViewCell: ReusableTableViewCell {

    @IBOutlet weak var providerBgImage: UIImageView!
    @IBOutlet weak var bgCoverView: UIView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carTitleLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
    
    /// Car model to be displayed
    var car: FLTCar! {
        didSet {
            providerBgImage.sd_setImage(with: car.provider.image.preview)
            carImage.sd_setImage(with: car.image.thumb)
            carTitleLabel.text = car.model.modelName
            fuelLabel.text = car.fuel.formatted
            licenseLabel.text = car.license
            providerLabel.text = "\(car.model.manufacturer.name) provided by \(car.provider.name)"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        updateState(highlighted: selected, animated: true)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        updateState(highlighted: highlighted, animated: true)
    }
    
    private func updateState(highlighted: Bool, animated: Bool) {
        let actions = {
            self.bgCoverView.backgroundColor = UIColor(white: 1, alpha: highlighted ? 0.8 : 0.9)
        }
        if animated {
            UIView.animate(withDuration: 0.3, animations: actions)
        }
        else {
            actions()
        }
    }
}
