//
//  SettingsViewController.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/16/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var listImageTypeSegment: UISegmentedControl!
    @IBOutlet weak var gridImageTypeSegment: UISegmentedControl!
    
    // MARK: --
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        listImageTypeSegment.selectedSegmentIndex = Settings.listImageType.hashValue
        gridImageTypeSegment.selectedSegmentIndex = Settings.gridImageType.hashValue
    }
}

// MARK: --
// MARK: IBAction Methods
extension SettingsViewController {
    @IBAction func imageTypeSegmentChanged(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex
        
        guard let segmentTitle = sender.titleForSegment(at: segmentIndex) else { return }
        guard let imageType = ImageType(rawValue: segmentTitle.lowercased()) else { return }

        if sender.tag == 0 {
            Settings.listImageType = imageType
        }
        else if sender.tag == 1 {
            Settings.gridImageType = imageType
        }
    }
}
