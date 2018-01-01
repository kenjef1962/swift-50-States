//
//  Enums.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/17.
//  Copyright © 2017 Kendall Jefferson. All rights reserved.
//

import Foundation

enum ImageSize: String {
    case small = "small"
    case large = "large"
    
    var stringValue: String {
        return self.rawValue
    }
}

enum ImageType: String {
    case flag = "flag"
    case map = "map"
    case seal = "seal"
    case quarter = "quarter"
    case none = "none"
    
    var stringValue: String {
        return self.rawValue
    }
}

enum InfoType: String {
    
    case admission = "Admission"
    case bird = "Bird"
    case capital = "Capital"
    case flag = "Flag"
    case flower = "Flower"
    case map = "Map"
    case tree = "Tree"
    case seal = "Seal"
    case song = "Song"
    case quarter = "Quarter"
    
    var stringValue: String {
        return self.rawValue
    }
    
    var imageType: ImageType {
        switch self {
        case .flag: return ImageType.flag
        case .map: return ImageType.map
        case .seal: return ImageType.seal
        case .quarter: return ImageType.quarter
        default: return ImageType.none
        }
    }
}
