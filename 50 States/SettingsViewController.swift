//
//  SettingsViewController.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/16/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var imageTypeSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        imageTypeSegment.selectedSegmentIndex = Utils.defaultImageType.hashValue
    }
    
    @IBAction func imageTypeSegmentChanged(_ sender: UISegmentedControl) {
        let segmentIndex = imageTypeSegment.selectedSegmentIndex
        
        guard let segmentTitle = imageTypeSegment.titleForSegment(at: segmentIndex) else { return }
        guard let defaultImageType = StateImageType(rawValue: segmentTitle.lowercased()) else { return }

        Utils.defaultImageType = defaultImageType
    }
}
