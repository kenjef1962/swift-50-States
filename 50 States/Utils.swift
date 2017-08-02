//
//  Utils.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/12/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    class var defaultImageType: StateImageType {
        get {
            
            let defaults = UserDefaults.standard
            let rawValue = defaults.object(forKey: "imageType") as? String ?? StateImageType.flag.rawValue
            let imageType = StateImageType(rawValue: rawValue) ?? StateImageType.flag
            
            return imageType
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue.rawValue, forKey: "imageType")
        }
    }
    
    class func showBasicAlert(_ title: String,  message: String, viewController: UIViewController, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: nil)
        
        alert.addAction(action)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func roundViewCorners(_ view: UIView, radius: Int = 10) {
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
}
