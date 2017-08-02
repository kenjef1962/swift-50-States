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
    
    fileprivate var state: State?
    
    func setup(_ imageType: StateImageType, state : State)
    {
        self.state = state
        
        cellImageView.image = UIImage(named: "loading")
        cellNameLabel.text = state.name
        cellNicknameLabel.text = state.nickname
        cellAbbreviationLabel.text = state.abbreviation
        
        state.getImage(imageType, imageSize: .small) { image in
            self.cellImageView.image = image
        }
    }
    
    override func prepareForReuse() {
        cellImageView.image = nil
        cellNameLabel.text = nil
        cellNicknameLabel.text = nil
        cellAbbreviationLabel.text = nil
    }
}
