//
//  State.swift
//  50 States
//
//  Created by Kendall Jefferson on 7/31/15.
//  Copyright (c) 2015 Kendall Jefferson. All rights reserved.
//

import Foundation
import UIKit

import SwiftyJSON


struct State {
    var name: String
    var abbreviation: String
    var nickname: String
    var capitalCity: String?
    var largestCity: String?
    var mapLatitude: String?
    var mapLongitude: String?
    
    var items = [InfoItem]()
    
    init?(json: JSON) {
        guard let name = json["name"].string else { return nil }
        guard let abbreviation = json["name-abbreviation"].string else { return nil }
        guard let nickname = json["name-nickname"].string else { return nil }

        self.name = name
        self.abbreviation = abbreviation
        self.nickname = nickname
        
        capitalCity = json["city-capital"].string
        largestCity = json["city-largest"].string

        mapLatitude = json["map-latitude"].string
        mapLongitude = json["map-longitude"].string
        
        items.append(InfoItem(json: json, type: .admission, valueKey: "admission", descriptionKey: "admission-desc"))
        items.append(InfoItem(json: json, type: .bird, valueKey: "bird", descriptionKey: "bird-desc"))
        items.append(InfoItem(json: json, type: .flag, valueKey: "flag", descriptionKey: "flag-desc"))
        items.append(InfoItem(json: json, type: .flower, valueKey: "flower", descriptionKey: "flower-desc"))
        items.append(InfoItem(json: json, type: .map, valueKey: "map", descriptionKey: "map-desc"))
        items.append(InfoItem(json: json, type: .quarter, valueKey: "quarter", descriptionKey: "quarter-desc"))
        items.append(InfoItem(json: json, type: .seal, valueKey: "seal", descriptionKey: "seal-desc"))
        items.append(InfoItem(json: json, type: .song, valueKey: "song", descriptionKey: "song-desc"))
        items.append(InfoItem(json: json, type: .tree, valueKey: "tree", descriptionKey: "tree-desc"))
    }
}

struct InfoItem {
    var type: InfoType
    var value: String?
    var description: String?
    
    init(json: JSON, type: InfoType, valueKey: String?, descriptionKey: String?) {
        self.type = type
        
        if let valueKey = valueKey {
            self.value = json[valueKey].string
        }
        
        if let descriptionKey = descriptionKey {
            self.description = json[descriptionKey].string
        }
    }
}
