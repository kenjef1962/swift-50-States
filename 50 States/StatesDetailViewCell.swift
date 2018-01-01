//
//  StatesDetailViewCell.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/12/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesDetailViewCell: UITableViewCell {

    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var infoTypeLabel: UILabel!
    @IBOutlet weak var infoValueLabel: UILabel!
    @IBOutlet weak var infoDetailLabel: UILabel!
    @IBOutlet weak var infoActivityIndicator: UIActivityIndicatorView!
    
    static let cellIdentifier = "infoCell"

    func configure(state: State, infoItem: InfoItem) {
        accessoryType = .none
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        
        infoImageView.image = nil
        infoTypeLabel.text = infoItem.type.stringValue
        infoValueLabel.text = infoItem.value
        infoDetailLabel.text = infoItem.description
        
        infoActivityIndicator.startAnimating()
        
        DataManager.instance.getImage(state: state, imageType: infoItem.type.imageType, imageSize: .small) { image in
            self.accessoryType = image == nil ? .none : .disclosureIndicator
            self.infoActivityIndicator.stopAnimating()
            self.infoImageView.image = image
        }
        
        guard infoItem.type.imageType == .none else { return }
        guard let value = infoItem.value else { return }
        guard let description = infoItem.description else { return }
        
        if !value.isEmpty && !description.isEmpty {
            accessoryType = .detailButton
        }
    }
}
