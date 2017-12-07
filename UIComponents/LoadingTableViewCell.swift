//
//  LoadingTableViewCell.swift
//  FleetbutlerDemo
//
//  Created by Azat Almeev on 26.11.2017.
//  Copyright © 2017 Azat Almeev. All rights reserved.
//

import UIKit

/// Cell that s able to show indicator or error message
public final class LoadingTableViewCell: ReusableTableViewCell {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tapToRetryLabel: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    /// Error to display. If nil indicator will be show
    public var error: Error? {
        didSet {
            tapToRetryLabel.isHidden = error == nil
            if let error = error {
                selectionStyle = .default
                indicator.stopAnimating()
                errorLabel.text = error.localizedDescription
            }
            else {
                selectionStyle = .none
                indicator.startAnimating()
                errorLabel.text = nil
            }
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        error = nil
        tapToRetryLabel.text = CommonStrings.tapToRetry
    }
}
