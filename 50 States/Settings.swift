//
//  UserDefaults.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

class Settings {
    class var listImageType: ImageType {
        get {
            
            let defaults = UserDefaults.standard
            let rawValue = defaults.object(forKey: "listImageType") as? String ?? ImageType.flag.rawValue
            let imageType = ImageType(rawValue: rawValue) ?? ImageType.flag
            
            return imageType
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue.rawValue, forKey: "listImageType")
        }
    }
    
    class var gridImageType: ImageType {
        get {
            
            let defaults = UserDefaults.standard
            let rawValue = defaults.object(forKey: "gridImageType") as? String ?? ImageType.flag.rawValue
            let imageType = ImageType(rawValue: rawValue) ?? ImageType.flag
            
            return imageType
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue.rawValue, forKey: "gridImageType")
        }
    }
}
