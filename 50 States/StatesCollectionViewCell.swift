//
//  StatesCollectionViewCell.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/12/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class StatesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellActivityIndicator: UIActivityIndicatorView!
    
    static let cellIdentifier = "statesCell"
    
    func configure(imageType: ImageType, state : State)
    {
        cellImageView.image = nil
        cellNameLabel.text = state.name
        cellActivityIndicator.startAnimating()
        
        DataManager.instance.getImage(state: state, imageType: imageType, imageSize: .small) { image in
            DispatchQueue.main.async {
                self.cellActivityIndicator.stopAnimating()
                self.cellImageView.image = image
            }
        }
    }
}
