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
    
    var state: State!
    var symbol: (type: String, name: String?, description: String?)!
    
    func setup(_ state: State, symbolType: String) {
        self.state = state
        self.title = symbolType
        
        for symbol in state.symbols {
            if (symbol.type == symbolType) {
                self.symbol = symbol
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utils.roundViewCorners(symbolDescriptionLabel)

        symbolTitleLabel.text = "State \(symbol.type) of \(state.name)"
        symbolDescriptionLabel.text = symbol.description ?? ""
        
        symbolImageView.contentMode = .center
        symbolImageView.image = UIImage(named: "loading")
        
        if let imageType = StateImageType(rawValue: symbol.type.lowercased()) {
            state.getImage(imageType, imageSize: .large) { image in
                self.symbolImageView.contentMode = .center
                self.symbolImageView.image = image
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        symbolDescriptionLabel.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
