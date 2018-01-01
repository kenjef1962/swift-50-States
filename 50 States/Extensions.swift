//
//  Extensions.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/12/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func showBasicAlert(_ title: String,  message: String, viewController: UIViewController, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: nil)
        
        alert.addAction(action)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    func roundCorners(radius: CGFloat = 10) {
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = radius
    }
}
