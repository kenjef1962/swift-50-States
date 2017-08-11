//
//  State.swift
//  50 States
//
//  Created by Kendall Jefferson on 7/31/15.
//  Copyright (c) 2015 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

enum StateImageSize: String {
    case small = "small"
    case large = "large"
    
    var stringValue: String {
        return self.rawValue
    }
}

enum StateImageType: String {
    case flag = "flag"
    case map = "map"
    case seal = "seal"
    case quarter = "quarter"
    
    var stringValue: String {
        return self.rawValue
    }
}

class State {
    fileprivate var imageCache: [String: UIImage] = [:]
    
    var name: String
    var abbreviation: String
    var nickname: String
    var admissionDate: String
    var admissionOrder: String
    
    var symbols = [(type: String, name: String?, description: String?)]()
    
    init(json: JSON) {
        name = json["name"].string ?? "[missing]"
        abbreviation = json["name-abbreviation"].string ?? "[missing]"
        nickname = json["name-nickname"].string ?? "[missing]"
        admissionDate = json["admission-date"].string ?? "[missing]"
        admissionOrder = json["admission-order"].string ?? "[missing]"
        
        symbols.append(("Flag", nil, json["desc-flag"].string ?? nil))
        symbols.append(("Seal", nil, json["desc-seal"].string ?? nil))
        symbols.append(("Quarter", json["symbol-quarter"].string ?? nil, json["desc-quarter"].string ?? nil))
        
        symbols.append(("Bird", json["symbol-bird"].string ?? nil, json["desc-bird"].string ?? nil))
        symbols.append(("Flower", json["symbol-flower"].string ?? nil, json["desc-flower"].string ?? nil))
        symbols.append(("Tree", json["symbol-tree"].string ?? nil, json["desc-tree"].string ?? nil))
        symbols.append(("Song", json["symbol-song"].string ?? nil, json["desc-song"].string ?? nil))
    }

    fileprivate func getImagePath(_ imageType: StateImageType, imageSize: StateImageSize) -> String {
        var imagePath = "http://www.50states.com/images/redesign/\(imageType.stringValue)s/"
        
        switch imageType {
        case .quarter:
            imagePath += "\(name)_\(imageSize.stringValue)_\(imageType.stringValue).png"
            break
        default:
            imagePath += "\(abbreviation)-\(imageSize.stringValue)\(imageType.stringValue).png"
            break
        }
        
        return imagePath.replacingOccurrences(of: " ", with: "_").lowercased()
    }

    func getImage(_ imageType: StateImageType, imageSize: StateImageSize, completion: @escaping (UIImage?) -> Void) {
        let key = "\(imageType.stringValue)-\(imageSize.stringValue)"
        
        if let image = imageCache[key] {
            return completion(image)
        }
        
        let imagePath = getImagePath(imageType, imageSize: imageSize)
        guard let imageURL = URL(string: imagePath) else { return completion(nil) }
        
        Alamofire.request(imageURL, method: .get).responseImage { response in
            guard let image = response.result.value else { return completion(nil) }

            self.imageCache[key] = image
            return completion(image)
        }
    }
}
