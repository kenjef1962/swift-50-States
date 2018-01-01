//
//  StatesTableViewCell.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellNicknameLabel: UILabel!
    @IBOutlet weak var cellAbbreviationLabel: UILabel!
    @IBOutlet weak var cellActivityIndicator: UIActivityIndicatorView!
    
    static let cellIdentifier = "statesCell"
    
    func configure(imageType: ImageType, state : State)
    {
        layoutMargins = .zero
        preservesSuperviewLayoutMargins = false
        
        cellImageView.image = nil
        cellNameLabel.text = state.name
        cellNicknameLabel.text = state.nickname
        cellAbbreviationLabel.roundCorners(radius: cellAbbreviationLabel.frame.width / 2)
        cellAbbreviationLabel.text = state.abbreviation
        cellActivityIndicator.startAnimating()
        
        DataManager.instance.getImage(state: state, imageType: imageType, imageSize: .small) { image in
            DispatchQueue.main.async {
                self.cellImageView.image = image
                self.cellActivityIndicator.stopAnimating()
            }
        }
    }
}
