//
//  DataManager.swift
//  50 States
//
//  Created by Kendall Jefferson on 8/11/16.
//  Copyright © 2016 Kendall Jefferson. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {

    static let instance = DataManager()
    
    var states = [State]()
    
    func getStateList() -> [State] {
        if (states.count == 0) {
            guard let file = Bundle.main.path(forResource: "StatesInfo", ofType: "JSON") else { return states }
            guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: file)) else { return states }
            
            let json = JSON(data: jsonData)

            for (_, value) in json["States"] {
                let state = State(json: value)
                states.append(state)
            }
        }
        
        return states
    }
}
