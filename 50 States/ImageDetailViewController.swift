//
//  ImageDetailViewController.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/16/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var symbolTitleLabel: UILabel!
    @IBOutlet weak var symbolDescriptionLabel: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var state: State!
    var infoItem: InfoItem!
    
    static let identifier = "imageDetailViewController"
    
    func configure(_ state: State, infoItem: InfoItem) {
        self.state = state
        self.infoItem = infoItem
    }
}

// MARK: --
// MARK: Life Cycle Methods
extension ImageDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = infoItem.type.stringValue

        var description = infoItem.value ?? ""
        description += !description.isEmpty ? "\n\n" : ""
        description += infoItem.description ?? ""

        
        symbolTitleLabel.text = "State \(infoItem.type.stringValue) of \(state.name)"
        symbolTitleLabel.roundCorners(radius: 5)
        symbolDescriptionLabel.text = description
        symbolDescriptionLabel.roundCorners()
        symbolImageView.image = nil

        activityIndicator.startAnimating()
        
        DataManager.instance.getImage(state: state, imageType: infoItem.type.imageType, imageSize: .large) { image in
            self.symbolImageView.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        symbolDescriptionLabel.setContentOffset(CGPoint.zero, animated: false)
    }
}

// MARK: --
// MARK: IBAction Methods
extension ImageDetailViewController {
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
